package member.controller.wonhyejin;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator extends Authenticator {
      
	@Override
	   public PasswordAuthentication getPasswordAuthentication() {
	     
	      return new PasswordAuthentication("leejjtest0791","crleohgomudjbxvk");  //발신자의 메일계정(@gmail.com을 제외한 부분)과 비밀번호
	   }
}
