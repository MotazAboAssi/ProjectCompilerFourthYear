import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Token;

import java.io.IOException;
import java.util.List;
import gen.*;

public class Main {
    public static void main(String[] args) throws IOException {

        // 1.  الدخل الذي نريد تحليله

        String filePath = "src/input.js";
        // 2. تمرير النص إلى الـ Lexer الذي قمنا بإنشائه
        LexerVariable lexer = new LexerVariable(CharStreams.fromFileName(filePath));

        // 3. جلب جميع التوكنز المستخرجة
        List<? extends Token> tokens = lexer.getAllTokens();


        System.out.println("--- Tokens Found ---");
        for (Token token : tokens) {
            // كود التوكن الاسمي
            String tokenName = lexer.getVocabulary().getSymbolicName(token.getType());
            // طباعة النص المستخرج ونوعه
            System.out.println("Text: [" + token.getText() + "] -> Type: " + tokenName);
        }
    }
}
