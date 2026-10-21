
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sign in | PrivacyCheck</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
<main class="auth-shell">

    <section class="auth-brand">
        <div class="brand-mark">P</div>
        <h1>Take control of your digital privacy.</h1>
        <p>
            Understand your connected services, shared data
            and privacy risks in one place.
        </p>
        <div class="trust-note">
            Your data. Your choices. Your control.
        </div>
    </section>

    <section class="auth-panel">
        <a class="brand-name"
           href="${pageContext.request.contextPath}/login">
            PrivacyCheck
        </a>

        <h2>Welcome back</h2>
        <p class="muted">
            Sign in to review your digital footprint.
        </p>

        <c:if test="${param.registered == '1'}">
            <div class="success" role="status">
                Account created successfully. You can sign in now.
            </div>
        </c:if>

        <c:if test="${not empty requestScope.error}">
            <div class="error" role="alert">
                <c:out value="${requestScope.error}"/>
            </div>
        </c:if>

        <form method="post"
              action="${pageContext.request.contextPath}/login">

            <label for="email">Email address</label>
            <input
                id="email"
                type="email"
                name="email"
                autocomplete="email"
                maxlength="150"
                required>

            <label for="password">Password</label>
            <input
                id="password"
                type="password"
                name="password"
                autocomplete="current-password"
                required>

            <button class="primary-btn" type="submit">
                Sign in
            </button>
        </form>

        <div class="separator"><span>or</span></div>

        <a class="google-btn"
           href="${pageContext.request.contextPath}/google/login">
            <span aria-hidden="true">G</span>
            Continue with Google
        </a>

        <p class="bottom-text">
            New to PrivacyCheck?
            <a href="${pageContext.request.contextPath}/register">
                Create an account
            </a>
        </p>
    </section>

</main>
</body>
</html>
