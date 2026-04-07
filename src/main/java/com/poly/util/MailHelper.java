package com.poly.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class MailHelper {

    private final String username; // smtp username (email)
    private final String password; // smtp password / app password
    private final Properties props;

    public MailHelper(String host, String port, String username, String password, boolean useTls) {
        this.username = username;
        this.password = password;
        props = new Properties();
        props.put("mail.smtp.auth", "true");
        if(useTls) {
            props.put("mail.smtp.starttls.enable", "true");
        }
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        // for SSL (e.g. 465)
        if ("465".equals(port)) {
            props.put("mail.smtp.socketFactory.port", port);
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        }
    }

    public void send(String from, String to, String subject, String htmlContent) throws MessagingException {
        Session session = Session.getInstance(props, new Authenticator(){
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject(subject);
        message.setContent(htmlContent, "text/html; charset=UTF-8");

        Transport.send(message);
    }
}
