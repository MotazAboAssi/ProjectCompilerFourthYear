import java.util.regex.Pattern;

public class LineContinuation {

    static final boolean TRIM_LEADING = true;
    static final String  INDENT = "";

    private static final Pattern CONT = Pattern.compile("\\\\(?:\\r\\n|\\r|\\n|\\u2028|\\u2029)");

    public static String toConcatenation(String raw) {
        char q = raw.charAt(0);
        String body = raw.substring(1, raw.length() - 1);
        String[] parts = CONT.split(body, -1);
        if (parts.length == 1) return raw;              // لا يوجد استمرار سطر
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < parts.length; i++) {
            String p = parts[i];
            if (TRIM_LEADING && i > 0) p = p.replaceFirst("^[ \\t]+", "");
            if (TRIM_LEADING && i < parts.length - 1 && !p.endsWith(" ")) p = p + " ";
            sb.append(q).append(p).append(q);
            if (i < parts.length - 1) sb.append(" +\n").append(INDENT);
        }
        return sb.toString();
    }
}
