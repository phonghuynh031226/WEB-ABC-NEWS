package com.poly.controller;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Arrays;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.oauth2.Oauth2;
import com.google.api.services.oauth2.model.Userinfo;

import com.poly.model.User;
import com.poly.model.Userinfoplus;

@WebServlet("/login-google")
public class GoogleLoginServlet extends HttpServlet {

	 private static final String CLIENT_ID = ""; 
	 private static final String CLIENT_SECRET = "";
    private static final String REDIRECT_URI = "http://localhost:8080/ASM_JAVA3_SOF203/login-google";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String code = req.getParameter("code");

        try {
            // 🟢 BƯỚC 1: Nếu chưa có code => chuyển hướng đến trang đăng nhập Google
            if (code == null || code.isEmpty()) {
                String authorizationUrl = "https://accounts.google.com/o/oauth2/v2/auth?"
                        + "client_id=" + CLIENT_ID
                        + "&redirect_uri=" + REDIRECT_URI
                        + "&response_type=code"
                        + "&scope=" + String.join(" ",
                            Arrays.asList(
                                "https://www.googleapis.com/auth/userinfo.profile",
                                "https://www.googleapis.com/auth/userinfo.email"
                            )
                        )
                        + "&access_type=offline"
                        + "&prompt=consent";

                resp.sendRedirect(authorizationUrl);
                return;
            }

            // 🟢 BƯỚC 2: Đã có code => gọi Google để lấy Access Token
            GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                    GoogleNetHttpTransport.newTrustedTransport(),
                    JacksonFactory.getDefaultInstance(),
                    "https://oauth2.googleapis.com/token",
                    CLIENT_ID,
                    CLIENT_SECRET,
                    code,
                    REDIRECT_URI
            ).execute();

         // 🟢 BƯỚC 3: Lấy thông tin người dùng từ Google
            Oauth2 oauth2 = new Oauth2.Builder(
                    GoogleNetHttpTransport.newTrustedTransport(),
                    JacksonFactory.getDefaultInstance(),
                    new com.google.api.client.auth.oauth2.Credential(
                            com.google.api.client.auth.oauth2.BearerToken.authorizationHeaderAccessMethod()
                    ).setAccessToken(tokenResponse.getAccessToken())
            ).setApplicationName("ASM_JAVA3_SOF203").build();

            Userinfo googleInfo = oauth2.userinfo().get().execute();


            // 🟢 BƯỚC 4: Lưu thông tin user vào session
            Userinfoplus userInfo = new Userinfoplus();
            userInfo.setId(googleInfo.getId());
            userInfo.setEmail(googleInfo.getEmail());
            userInfo.setName(googleInfo.getName());
            userInfo.setPicture(googleInfo.getPicture());

            HttpSession session = req.getSession();
            User user = new User();
            user.setId(userInfo.getEmail());
            user.setFullname(userInfo.getName());
            user.setEmail(userInfo.getEmail());
            user.setRole(false);
            session.setAttribute("user", user);

            // 🟢 BƯỚC 5: Chuyển về trang chủ
            resp.sendRedirect(req.getContextPath() + "/home");

        } catch (GeneralSecurityException | IOException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/login?error=google");
        }
    }
}
