
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PrivacyCheck | Dashboard</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>

<c:set var="displayName" value="${sessionScope.userName}" />

<c:if test="${empty displayName}">
    <c:set var="displayName" value="User" />
</c:if>

<nav aria-label="Main navigation">
    <a class="brand-name"
       href="${pageContext.request.contextPath}/dashboard">
        <span class="brand-icon">P</span>
        PrivacyCheck
    </a>

    <div class="nav-links">
        <a class="active"
           href="${pageContext.request.contextPath}/dashboard">Dashboard</a>

        <a href="${pageContext.request.contextPath}/services">My Services</a>

        <a href="${pageContext.request.contextPath}/shared-data">Shared Data</a>

        <a href="${pageContext.request.contextPath}/reminders">Review Reminders</a>
    </div>

    <div class="nav-user">
        <div class="user-avatar">
            <c:out value="${displayName.substring(0, 1).toUpperCase()}" />
        </div>

        <div class="user-info">
            <strong><c:out value="${displayName}" /></strong>
            <span><c:out value="${sessionScope.userEmail}" default="PrivacyCheck account" /></span>
        </div>

        <form method="post"
              action="${pageContext.request.contextPath}/logout"
              class="logout-form">
            <button type="submit" class="logout-btn">
                <span aria-hidden="true">↪</span> Log out
            </button>
        </form>
    </div>
</nav>

<main>
    <section class="welcome-banner">
        <div class="welcome-copy">
            <p class="eyebrow">PERSONAL DATA SHARING AUDIT</p>

            <h1>
                Welcome back, <c:out value="${displayName}" />!
                <span aria-hidden="true">👋</span>
            </h1>

            <p class="subtitle">
                Take control of your digital privacy.
                Here's your personal privacy overview.
            </p>
        </div>

        <div class="welcome-decoration" aria-hidden="true">
            <div class="shield">✓</div>
            <div class="decoration-caption">Your data. Your control.</div>
        </div>
    </section>

    <section class="section-title">
        <div>
            <h2>Your Privacy at a Glance</h2>
            <p>Monitor your services and upcoming reviews.</p>
        </div>
        <span class="live-label">
            <span class="live-dot"></span> Your overview
        </span>
    </section>

    <section class="cards" aria-label="Privacy statistics">

        <div class="card">
            <div class="card-top">
                <span class="stat-icon purple">▤</span>
                <span class="stat-label">SERVICES</span>
            </div>
            <p>Total Services</p>
            <div class="number">
                <c:out value="${totalServices}" default="0"/>
            </div>
            <span class="card-caption">Tracked online services</span>
        </div>

        <div class="card">
            <div class="card-top">
                <span class="stat-icon red">!</span>
                <span class="stat-label">HIGH RISK</span>
            </div>
            <p>High-Risk Services</p>
            <div class="number high">
                <c:out value="${highRisk}" default="0"/>
            </div>
            <span class="card-caption">Need extra attention</span>
        </div>

        <div class="card">
            <div class="card-top">
                <span class="stat-icon orange">◷</span>
                <span class="stat-label">MEDIUM RISK</span>
            </div>
            <p>Medium-Risk Services</p>
            <div class="number medium">
                <c:out value="${mediumRisk}" default="0"/>
            </div>
            <span class="card-caption">Review recommended</span>
        </div>

        <div class="card">
            <div class="card-top">
                <span class="stat-icon green">✓</span>
                <span class="stat-label">LOW RISK</span>
            </div>
            <p>Low-Risk Services</p>
            <div class="number low">
                <c:out value="${lowRisk}" default="0"/>
            </div>
            <span class="card-caption">Lower assessed risk</span>
        </div>

        <div class="card">
            <div class="card-top">
                <span class="stat-icon red">⌛</span>
                <span class="stat-label">OVERDUE</span>
            </div>
            <p>Overdue Reviews</p>
            <div class="number high">
                <c:out value="${overdueReviews}" default="0"/>
            </div>
            <span class="card-caption">Past their review date</span>
        </div>

        <div class="card">
            <div class="card-top">
                <span class="stat-icon blue">▦</span>
                <span class="stat-label">UPCOMING</span>
            </div>
            <p>Reviews in Next 7 Days</p>
            <div class="number">
                <c:out value="${upcomingReviews}" default="0"/>
            </div>
            <span class="card-caption">Coming up soon</span>
        </div>

    </section>

    <section class="section">
        <div class="section-heading">
            <div>
                <h2>Privacy Management</h2>
                <p>Everything you need to manage your personal data sharing.</p>
            </div>
        </div>

        <div class="links">
            <a href="${pageContext.request.contextPath}/services">
                <span class="link-icon">01</span>
                <span>
                    <strong>My Services</strong>
                    <small>Review your connected online services</small>
                </span>
                <span class="arrow" aria-hidden="true">→</span>
            </a>

            <a href="${pageContext.request.contextPath}/shared-data">
                <span class="link-icon">02</span>
                <span>
                    <strong>Shared Data</strong>
                    <small>Explore your recorded data sharing</small>
                </span>
                <span class="arrow" aria-hidden="true">→</span>
            </a>

            <a href="${pageContext.request.contextPath}/reminders">
                <span class="link-icon">03</span>
                <span>
                    <strong>Review Reminders</strong>
                    <small>Check overdue and upcoming reviews</small>
                </span>
                <span class="arrow" aria-hidden="true">→</span>
            </a>
        </div>
    </section>
</main>

<footer>
    PrivacyCheck <span>•</span> Advanced Internet Programming Project
</footer>

</body>
</html>
