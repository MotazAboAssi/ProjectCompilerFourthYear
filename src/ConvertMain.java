import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Token;

import java.io.IOException;
import java.nio.file.*;
import java.util.List;
import gen.*;

public class ConvertMain {
    public static void main(String[] args) throws IOException {
        String path = "src/input.js";
        String src  = Files.readString(Path.of(path));

        MainLexer lexer = new MainLexer(CharStreams.fromString(src));
        List<? extends Token> tokens = lexer.getAllTokens();

        StringBuilder out = new StringBuilder();
        int last = 0;
        for (Token t : tokens) {
            if (!"STRING".equals(lexer.getVocabulary().getSymbolicName(t.getType()))) continue;
            out.append(src, last, t.getStartIndex());
            out.append(LineContinuation.toConcatenation(t.getText()));
            last = t.getStopIndex() + 1;
        }
        out.append(src.substring(last));

        System.out.println(out);
        Files.writeString(Path.of("src/output.js"), out.toString());
    }
}
