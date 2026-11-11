import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Token;

import java.io.IOException;
import java.util.List;
import gen.*;

public class Main {
    public static void main(String[] args) throws IOException {

        // 1. الملف الذي نريد تحليله
        String filePath = "src/input.js";

        // 2. نستخدم الـ Lexer المدمج MainLexer (بدل LexerVariable وحده)
        MainLexer lexer = new MainLexer(CharStreams.fromFileName(filePath));

        // 3. جلب جميع التوكنز
        List<? extends Token> tokens = lexer.getAllTokens();

        System.out.println("--- Tokens Found ---");
        for (Token token : tokens) {
            String tokenName = lexer.getVocabulary().getSymbolicName(token.getType());
            System.out.println("Text: [" + token.getText() + "] -> Type: " + tokenName);

            // للنصوص: اطبع القيمة الفعلية بعد حذف علامات "\ + سطر جديد"
            if ("STRING".equals(tokenName)) {
                String raw = token.getText();
                String body = raw.substring(1, raw.length() - 1);
                String value = body.replaceAll("\\\\(\\r\\n|\\r|\\n|\\u2028|\\u2029)", "");
                System.out.println("   Value: [" + value + "]");
            }
        }
    }
}
