package member.controller.wonhyejin;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class GmailSpend {

	public void sendmail(String recipient, String certificationCode) throws Exception {
	
		// Property에 SMTP 서버 정보 설정  smtp는 발신메일
		
        Properties prop = new Properties(); 
       
        prop.put("mail.smtp.user", "leejjtest0791@gmail.com"); // 자신의 이메일 주소  
        
        prop.put("mail.smtp.host", "smtp.gmail.com");
             
        
        prop.put("mail.smtp.port", "465");   
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.debug", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        prop.put("mail.smtp.socketFactory.fallback", "false");
        
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
          
        
        Authenticator smtpAuth = new MySMTPAuthenticator();   
        Session session = Session.getInstance(prop, smtpAuth);   //메일 세션 생성
        
        session.setDebug(true);   //콘솔에 출력 
                
        // 메일의 내용을 담기 위한 객체생성
        MimeMessage msg = new MimeMessage(session);

        //메일 제목
        String subject = "<semi_prj_shoes>회원님의 비밀번호를 찾기 위한 인증코드 발송";
        msg.setSubject(subject);
                
        // 발신자의 메일주소
        String sender = "leejjtest0791@gmail.com";
        Address fromAddr = new InternetAddress(sender);
        msg.setFrom(fromAddr);
                
        // 수진자의 메일주소
        Address toAddr = new InternetAddress(recipient);
        msg.addRecipient(Message.RecipientType.TO, toAddr);
                
       // 내용
        msg.setContent("발송된 인증코드 : <span style='font-size:14pt; color:red;'>"+certificationCode+"</span>", "text/html;charset=UTF-8");
                
        // 메일 보내기
        Transport.send(msg);
        
     }// end of sendmail()-----------------
}
