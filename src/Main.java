import gen.TemplateLiterals;
import org.antlr.v4.runtime.*;

public class Main {
    public static void main(String[] args) {
        // نص تجريبي يجمع: كلمة محجوزة + متغير + نص عادي + Template Literal
        String code = "const user = \"Ali\"; `Hello ${user} ${10 + 20}`;";

        CharStream input = CharStreams.fromString(code);
        TemplateLiterals lexer = new TemplateLiterals(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        tokens.fill();

        for (Token token : tokens.getTokens()) {
            if (token.getType() == Token.EOF) break;
            String tokenName = lexer.getVocabulary().getSymbolicName(token.getType());
            System.out.printf("Token: %-18s | Text: %s%n", tokenName, token.getText());
        }
    }
}
