package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {
    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        // INFO: 관리자의 아이디와 비밀번호를 입력해야 함
        return new PasswordAuthentication(System.getenv("DEV_USER"), System.getenv("DEV_PASSWORD"));
    }
}
