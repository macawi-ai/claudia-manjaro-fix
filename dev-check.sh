#!/bin/bash

# Development validation script for claudia-manjaro-fix
# Run this before committing changes

echo "🔧 Claudia Manjaro Fix - Development Validation"
echo "=============================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track issues
ISSUES=0
WARNINGS=0

# Function to report issues
report_error() {
    echo -e "${RED}❌ $1${NC}"
    ISSUES=$((ISSUES + 1))
}

report_warning() {
    echo -e "${YELLOW}⚠  $1${NC}"
    WARNINGS=$((WARNINGS + 1))
}

report_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Check if install.sh exists
if [ ! -f "install.sh" ]; then
    report_error "install.sh not found"
    exit 1
fi

# 1. Bash syntax validation
echo "🔍 Checking bash syntax..."
if bash -n install.sh 2>/dev/null; then
    report_success "Bash syntax is valid"
else
    report_error "Bash syntax errors found:"
    bash -n install.sh
fi

# 2. Check heredoc EOF markers
echo ""
echo "🔍 Checking heredoc blocks..."
HEREDOC_STARTS=$(grep -c "<<[[:space:]]*['\"].*EOF\|<<[[:space:]]*[A-Z_]*EOF[[:space:]]*$" install.sh 2>/dev/null || echo "0")
HEREDOC_ENDS=$(grep -c "^[A-Z_]*EOF$" install.sh 2>/dev/null || echo "0")

if [ "$HEREDOC_STARTS" -eq "$HEREDOC_ENDS" ]; then
    report_success "Heredoc blocks balanced ($HEREDOC_STARTS start/end pairs)"
else
    report_error "Unbalanced heredoc blocks: $HEREDOC_STARTS starts, $HEREDOC_ENDS ends"
    echo "EOF markers found:"
    grep -n "<<\|_EOF$" install.sh
fi

# 3. Check for unquoted heredoc markers
echo ""
echo "🔍 Checking heredoc quoting..."
UNQUOTED_HEREDOCS=$(grep "<<[[:space:]]*[A-Z_]*EOF[[:space:]]*$" install.sh 2>/dev/null | grep -v "'.*EOF'" | wc -l || echo "0")
if [ "$UNQUOTED_HEREDOCS" -eq 0 ]; then
    report_success "All heredoc markers properly quoted"
else
    report_warning "Found potentially unquoted heredoc markers:"
    grep -n "<<[[:space:]]*[A-Z_]*EOF[[:space:]]*$" install.sh | grep -v "'.*EOF'"
fi

# 4. Check for common script issues
echo ""
echo "🔍 Checking for common issues..."

# Check for proper shebang
if head -1 install.sh | grep -q "^#!/bin/bash"; then
    report_success "Proper shebang found"
else
    report_warning "Missing or incorrect shebang"
fi

# Check for set -e usage (we intentionally don't use it)
if grep -q "set -e" install.sh; then
    report_warning "Found 'set -e' - verify this is intentional"
fi

# Check for unescaped variables in heredocs
if grep -A 20 "<<[[:space:]]*[A-Z_]*EOF" install.sh | grep -v "'.*EOF'" | grep -q '\$[A-Za-z_]'; then
    report_warning "Potential variable expansion in heredocs (verify intentional)"
fi

# 5. Test built-in validation
echo ""
echo "🔍 Testing built-in validation..."
if ./install.sh --validate >/dev/null 2>&1; then
    report_success "Built-in validation passes"
else
    report_error "Built-in validation failed"
fi

# 6. Check file permissions
echo ""
echo "🔍 Checking file permissions..."
if [ -x "install.sh" ]; then
    report_success "install.sh is executable"
else
    report_warning "install.sh is not executable (run: chmod +x install.sh)"
fi

# 7. Check for TODOs and FIXMEs
echo ""
echo "🔍 Checking for development notes..."
TODO_COUNT=$(grep "TODO\|FIXME\|XXX" install.sh 2>/dev/null | wc -l || echo "0")
if [ "$TODO_COUNT" -gt 0 ]; then
    report_warning "Found $TODO_COUNT development notes:"
    grep -n "TODO\|FIXME\|XXX" install.sh
else
    report_success "No development notes found"
fi

# Summary
echo ""
echo "📊 Validation Summary"
echo "===================="
if [ $ISSUES -eq 0 ]; then
    report_success "All critical checks passed!"
    if [ $WARNINGS -eq 0 ]; then
        echo -e "${GREEN}🎉 Script is ready for production${NC}"
        exit 0
    else
        echo -e "${YELLOW}⚠  $WARNINGS warnings found - review before committing${NC}"
        exit 0
    fi
else
    report_error "$ISSUES critical issues found"
    if [ $WARNINGS -gt 0 ]; then
        echo -e "${YELLOW}   Plus $WARNINGS warnings${NC}"
    fi
    echo -e "${RED}🛑 Fix issues before committing${NC}"
    exit 1
fi