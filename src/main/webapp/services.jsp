<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PrivacyCheck | My Services</title>

    <style>
        /* =========================
           GLOBAL STYLES
        ========================= */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        :root {
            --primary: #6d4aff;
            --primary-dark: #5135d9;
            --primary-light: #f0edff;
            --background: #f7f8fc;
            --surface: #ffffff;
            --text: #252641;
            --muted: #7b8197;
            --border: #e9eaf2;
            --shadow: 0 8px 30px rgba(35, 32, 75, 0.055);
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Arial, sans-serif;
            background: var(--background);
            color: var(--text);
            line-height: 1.6;
        }

        a {
            text-decoration: none;
        }

        /* =========================
           HEADER
        ========================= */
        header {
            position: relative;
            overflow: hidden;
            padding: 28px 6%;
            color: #ffffff;
            background: linear-gradient(
                120deg,
                #21154e 0%,
                #4e35b5 52%,
                #7958ff 100%
            );
        }

        header::after {
            content: "";
            position: absolute;
            width: 230px;
            height: 230px;
            top: -145px;
            right: 8%;
            border: 1px solid rgba(255,255,255,0.16);
            border-radius: 50%;
            box-shadow:
                0 0 0 35px rgba(255,255,255,0.04),
                0 0 0 70px rgba(255,255,255,0.03);
            pointer-events: none;
        }

        .header-content {
            position: relative;
            z-index: 1;
            max-width: 1250px;
            margin: 0 auto;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 13px;
        }

        .brand-icon {
            display: grid;
            place-items: center;
            width: 45px;
            height: 45px;
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 14px;
            background: rgba(255,255,255,0.16);
            font-size: 23px;
            font-weight: 800;
        }

        .brand h1 {
            font-size: 25px;
            font-weight: 750;
            letter-spacing: -0.6px;
        }

        .brand p {
            margin-top: 1px;
            color: #ded7ff;
            font-size: 13px;
        }

        /* =========================
           NAVIGATION
        ========================= */
        nav {
            position: sticky;
            top: 0;
            z-index: 10;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            gap: 8px;
            padding: 13px 5%;
            background: rgba(255,255,255,0.96);
            border-bottom: 1px solid var(--border);
            box-shadow: 0 4px 15px rgba(25,24,60,0.025);
            backdrop-filter: blur(12px);
        }

        nav a {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 15px;
            border-radius: 10px;
            color: #626981;
            font-size: 13px;
            font-weight: 650;
            transition: all 0.2s ease;
        }

        nav a:hover {
            color: var(--primary);
            background: var(--primary-light);
        }

        nav a.active {
            color: var(--primary);
            background: var(--primary-light);
        }

        /* =========================
           MAIN CONTENT
        ========================= */
        main {
            width: min(1200px, 100%);
            margin: 0 auto;
            padding: 36px 25px 55px;
        }

        .top {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 28px;
        }

        .eyebrow {
            margin-bottom: 7px;
            color: var(--primary);
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 1.6px;
            text-transform: uppercase;
        }

        .top h2 {
            color: var(--text);
            font-size: clamp(26px, 4vw, 34px);
            line-height: 1.25;
            font-weight: 750;
            letter-spacing: -1px;
        }

        .muted {
            margin-top: 9px;
            color: var(--muted);
            font-size: 14px;
        }

        /* =========================
           BUTTON
        ========================= */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 9px;
            padding: 12px 18px;
            border: 1px solid transparent;
            border-radius: 11px;
            background: linear-gradient(
                135deg,
                var(--primary),
                #8268ff
            );
            box-shadow: 0 5px 14px rgba(109,74,255,0.2);
            color: #ffffff;
            font-size: 13px;
            font-weight: 700;
            transition: all 0.2s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
            background: var(--primary-dark);
            box-shadow: 0 8px 20px rgba(109,74,255,0.27);
        }

        .btn:focus-visible,
        nav a:focus-visible {
            outline: 3px solid #b8aaff;
            outline-offset: 3px;
        }

        /* =========================
           SUMMARY CARD
        ========================= */
        .summary {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            overflow: hidden;
            margin: 26px 0 30px;
            padding: 25px 28px;
            border: 1px solid #e4defe;
            border-radius: 18px;
            background: linear-gradient(
                110deg,
                #ffffff 0%,
                #f6f3ff 100%
            );
            box-shadow: var(--shadow);
        }

        .summary::after {
            content: "";
            position: absolute;
            width: 140px;
            height: 140px;
            right: 45px;
            top: -85px;
            border-radius: 50%;
            background: #e8e1ff;
            opacity: 0.65;
        }

        .summary-content {
            position: relative;
            z-index: 1;
        }

        .summary-label {
            color: #72768d;
            font-size: 13px;
            font-weight: 650;
        }

        .count {
            display: block;
            margin-top: 6px;
            color: var(--primary);
            font-size: 39px;
            line-height: 1.2;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .summary-note {
            display: block;
            margin-top: 6px;
            color: #8b8fa3;
            font-size: 12px;
        }

        .summary-icon {
            position: relative;
            z-index: 1;
            display: grid;
            place-items: center;
            width: 58px;
            height: 58px;
            flex-shrink: 0;
            border: 1px solid #e3dbff;
            border-radius: 17px;
            background: #ece7ff;
            color: var(--primary);
            font-size: 26px;
            font-weight: 800;
        }

        /* =========================
           TABLE SECTION
        ========================= */
        .section-heading {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 12px;
            margin-bottom: 17px;
        }

        .section-heading h3 {
            color: var(--text);
            font-size: 18px;
            font-weight: 750;
        }

        .section-heading p {
            margin-top: 3px;
            color: var(--muted);
            font-size: 12px;
        }

        .table-wrap {
            overflow: hidden;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 18px;
            box-shadow: var(--shadow);
        }

        .table-scroll {
            overflow-x: auto;
            width: 100%;
        }

        table {
            width: 100%;
            min-width: 900px;
            border-collapse: separate;
            border-spacing: 0;
        }

        thead th {
            padding: 17px 19px;
            background: #faf9ff;
            color: #777c92;
            border-bottom: 1px solid var(--border);
            text-align: left;
            white-space: nowrap;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        tbody td {
            padding: 18px 19px;
            color: #535970;
            border-bottom: 1px solid #f0f0f6;
            text-align: left;
            vertical-align: middle;
            font-size: 13px;
        }

        tbody tr {
            transition: background 0.2s ease;
        }

        tbody tr:hover {
            background: #fbfaff;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody td:first-child {
            color: #888da1;
            font-size: 12px;
            font-weight: 700;
        }

        tbody td:nth-child(2) {
            color: #292b45;
            font-weight: 700;
        }

        /* =========================
           RISK BADGES
        ========================= */
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 7px 11px;
            border: 1px solid transparent;
            border-radius: 30px;
            white-space: nowrap;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 0.5px;
        }

        .badge::before {
            content: "";
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
        }

        .HIGH {
            background: #fff0f0;
            color: #cf343b;
            border-color: #ffdddd;
        }

        .MEDIUM {
            background: #fff7e8;
            color: #b66a08;
            border-color: #ffebc6;
        }

        .LOW {
            background: #eaf9f0;
            color: #168354;
            border-color: #d2f1df;
        }

        /* =========================
           EMPTY STATE
        ========================= */
        .empty {
            padding: 55px 20px;
            background: #ffffff;
            text-align: center;
            border-radius: 16px;
        }

        .empty-icon {
            display: grid;
            place-items: center;
            width: 58px;
            height: 58px;
            margin: 0 auto 15px;
            border-radius: 18px;
            background: var(--primary-light);
            color: var(--primary);
            font-size: 26px;
        }

        .empty h3 {
            color: #292b45;
            font-size: 18px;
        }

        .empty p {
            margin-top: 7px;
            color: var(--muted);
            font-size: 13px;
        }

        /* =========================
           FOOTER
        ========================= */
        footer {
            padding: 24px 20px;
            border-top: 1px solid var(--border);
            background: #ffffff;
            color: #9297a9;
            text-align: center;
            font-size: 12px;
        }

        footer strong {
            color: var(--primary);
            font-weight: 750;
        }

        /* =========================
           RESPONSIVE
        ========================= */
        @media (max-width: 700px) {
            header {
                padding: 23px 20px;
            }

            nav {
                justify-content: flex-start;
                gap: 4px;
                padding: 10px 12px;
            }

            nav a {
                padding: 9px 10px;
                font-size: 11px;
            }

            main {
                padding: 28px 16px 40px;
            }

            .top {
                align-items: flex-start;
            }

            .btn {
                width: 100%;
            }

            .summary {
                padding: 22px;
            }

            .count {
                font-size: 34px;
            }

            .table-wrap {
                border-radius: 13px;
            }
        }

        @media (max-width: 400px) {
            .brand h1 {
                font-size: 22px;
            }

            .summary-icon {
                width: 48px;
                height: 48px;
                font-size: 22px;
            }

            .top h2 {
                font-size: 27px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                transition: none !important;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="header-content">
        <div class="brand">
            <div class="brand-icon">P</div>
            <div>
                <h1>PrivacyCheck</h1>
                <p>Personal Data Sharing Audit</p>
            </div>
        </div>
    </div>
</header>

<nav aria-label="Main navigation">
    <a href="${pageContext.request.contextPath}/dashboard">
        ◫ Dashboard
    </a>
    <a class="active"
       href="${pageContext.request.contextPath}/services"
       aria-current="page">
        ▤ My Services
    </a>
    <a href="${pageContext.request.contextPath}/shared-data">
        ◈ Shared Data
    </a>
    <a href="${pageContext.request.contextPath}/reminders">
        ◷ Review Reminders
    </a>
</nav>

<main>
    <div class="top">
        <div>
            <div class="eyebrow">Your privacy overview</div>
            <h2>My Services</h2>
            <p class="muted">
                Review your registered online services and understand
                their privacy risk levels.
            </p>
        </div>

        <a class="btn"
           href="${pageContext.request.contextPath}/dashboard">
            ← Back to Dashboard
        </a>
    </div>

    <div class="summary">
        <div class="summary-content">
            <p class="summary-label">Registered Online Services</p>
            <span class="count">
                <c:out value="${serviceCount}"/>
            </span>
            <span class="summary-note">
                Online services tracked in your privacy inventory
            </span>
        </div>

        <div class="summary-icon">▤</div>
    </div>

    <div class="section-heading">
        <div>
            <h3>Your Service Inventory</h3>
            <p>Services, risk levels, and scheduled privacy reviews</p>
        </div>
    </div>

    <c:choose>
        <c:when test="${empty services}">
            <div class="empty">
                <div class="empty-icon">▤</div>
                <h3>No services found</h3>
                <p>
                    No services are currently registered for this demo account.
                </p>
            </div>
        </c:when>

        <c:otherwise>
            <div class="table-wrap">
                <div class="table-scroll">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Service Name</th>
                                <th>Category</th>
                                <th>Risk Level</th>
                                <th>Shared Data Categories</th>
                                <th>Next Review</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="s" items="${services}">
                                <tr>
                                    <td>
                                        <c:out value="${s.id}"/>
                                    </td>
                                    <td>
                                        <c:out value="${s.name}"/>
                                    </td>
                                    <td>
                                        <c:out value="${s.category}"/>
                                    </td>
                                    <td>
                                        <span class="badge ${s.risk}">
                                            <c:out value="${s.risk}"/>
                                        </span>
                                    </td>
                                    <td>
                                        <c:out value="${s.sharedDataCount}"/>
                                    </td>
                                    <td>
                                        <c:out value="${s.nextReviewDate}"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<footer>
    <strong>PrivacyCheck</strong> &nbsp;|&nbsp; AIP Project
    <br>
    Personal data awareness and privacy review management
</footer>

</body>
</html>