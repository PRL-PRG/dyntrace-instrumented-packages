#include <Rinternals.h>

#define attribute_hidden
#define _(string) (string)


SEXP attribute_hidden new_captured_arg(SEXP x, SEXP env) {
    static SEXP nms = NULL;
    if (!nms) {
        nms = allocVector(STRSXP, 2);
        R_PreserveObject(nms);
        MARK_NOT_MUTABLE(nms);
        SET_STRING_ELT(nms, 0, mkChar("expr"));
        SET_STRING_ELT(nms, 1, mkChar("env"));
    }

    SEXP info = PROTECT(allocVector(VECSXP, 2));
    SET_VECTOR_ELT(info, 0, x);
    SET_VECTOR_ELT(info, 1, env);
    setAttrib(info, R_NamesSymbol, nms);

    UNPROTECT(1);
    return info;
}
SEXP attribute_hidden new_captured_literal(SEXP x) {
    return new_captured_arg(x, R_EmptyEnv);
}

SEXP attribute_hidden new_captured_promise(SEXP x, SEXP env) {
    SEXP expr_env = R_NilValue;

    SEXP expr = x;
    while (TYPEOF(expr) == PROMSXP) {
        expr_env = get_PRENV(expr);
        expr = get_PREXPR(expr);
    }

    // Evaluated arguments are returned as literals
    if (expr_env == R_NilValue) {
        SEXP value = PROTECT(eval(x, env));
        expr = new_captured_literal(value);
        UNPROTECT(1);
    } else {
        MARK_NOT_MUTABLE(expr);
        expr = new_captured_arg(expr, expr_env);
    }

    return expr;
}

SEXP attribute_hidden rlang_capturearginfo(SEXP call, SEXP op, SEXP args, SEXP rho)
{
    // Unwrap first layer of promise
    SEXP sym = findVarInFrame3(rho, install("x"), TRUE);

    // May be a literal if compiler did not wrap in a promise
    if (TYPEOF(sym) == PROMSXP)
        sym = get_PREXPR(sym);
    else
        return new_captured_literal(sym);

    if (TYPEOF(sym) != SYMSXP)
        error(_("\"x\" must be an argument name"));

    SEXP frame = CAR(args);
    SEXP arg = findVar(sym, frame);

    if (arg == R_UnboundValue)
        error(_("object '%s' not found"), CHAR(PRINTNAME(sym)));

    if (arg == R_MissingArg)
        return new_captured_literal(arg);
    else if (TYPEOF(arg) == PROMSXP)
        return new_captured_promise(arg, frame);
    else
        return new_captured_literal(arg);
}

SEXP capturedots(SEXP frame) {
    SEXP dots = PROTECT(findVar(R_DotsSymbol, frame));

    if (dots == R_UnboundValue) {
        error(_("Must capture dots in a function where dots exist"));
    }
    if (dots == R_MissingArg) {
        UNPROTECT(1);
        return allocVector(VECSXP, 0);
    }

    int n_dots = length(dots);
    SEXP captured = PROTECT(allocVector(VECSXP, n_dots));

    SEXP names = PROTECT(allocVector(STRSXP, n_dots));
    Rboolean named = FALSE;

    int i = 0;
    while (dots != R_NilValue) {
        SEXP head = CAR(dots);

        SEXP dot;
        if (TYPEOF(head) == PROMSXP)
            dot = new_captured_promise(head, frame);
        else
            dot = new_captured_literal(head);

        SET_VECTOR_ELT(captured, i, dot);

        if (TAG(dots) != R_NilValue) {
            named = TRUE;
            SET_STRING_ELT(names, i, PRINTNAME(TAG(dots)));
        }

        ++i;
        dots = CDR(dots);
    }

    if (named)
        setAttrib(captured, R_NamesSymbol, names);

    UNPROTECT(3);
    return captured;
}

SEXP attribute_hidden rlang_capturedots(SEXP call, SEXP op, SEXP args, SEXP rho)
{
    SEXP caller_env = CAR(args);
    return capturedots(caller_env);
}
