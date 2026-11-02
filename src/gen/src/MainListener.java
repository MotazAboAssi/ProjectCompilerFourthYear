// Generated from /home/motaz/Desktop/IdeaProjects/ProjectCompilerFourthYear/src/Main.g4 by ANTLR 4.13.2
package src;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link MainParser}.
 */
public interface MainListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link MainParser#program}.
	 * @param ctx the parse tree
	 */
	void enterProgram(MainParser.ProgramContext ctx);
	/**
	 * Exit a parse tree produced by {@link MainParser#program}.
	 * @param ctx the parse tree
	 */
	void exitProgram(MainParser.ProgramContext ctx);
	/**
	 * Enter a parse tree produced by {@link MainParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterStatement(MainParser.StatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MainParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitStatement(MainParser.StatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MainParser#block}.
	 * @param ctx the parse tree
	 */
	void enterBlock(MainParser.BlockContext ctx);
	/**
	 * Exit a parse tree produced by {@link MainParser#block}.
	 * @param ctx the parse tree
	 */
	void exitBlock(MainParser.BlockContext ctx);
	/**
	 * Enter a parse tree produced by {@link MainParser#varDecl}.
	 * @param ctx the parse tree
	 */
	void enterVarDecl(MainParser.VarDeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link MainParser#varDecl}.
	 * @param ctx the parse tree
	 */
	void exitVarDecl(MainParser.VarDeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link MainParser#assignment}.
	 * @param ctx the parse tree
	 */
	void enterAssignment(MainParser.AssignmentContext ctx);
	/**
	 * Exit a parse tree produced by {@link MainParser#assignment}.
	 * @param ctx the parse tree
	 */
	void exitAssignment(MainParser.AssignmentContext ctx);
	/**
	 * Enter a parse tree produced by {@link MainParser#ifStatement}.
	 * @param ctx the parse tree
	 */
	void enterIfStatement(MainParser.IfStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MainParser#ifStatement}.
	 * @param ctx the parse tree
	 */
	void exitIfStatement(MainParser.IfStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MainParser#whileStatement}.
	 * @param ctx the parse tree
	 */
	void enterWhileStatement(MainParser.WhileStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MainParser#whileStatement}.
	 * @param ctx the parse tree
	 */
	void exitWhileStatement(MainParser.WhileStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MainParser#printStatement}.
	 * @param ctx the parse tree
	 */
	void enterPrintStatement(MainParser.PrintStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MainParser#printStatement}.
	 * @param ctx the parse tree
	 */
	void exitPrintStatement(MainParser.PrintStatementContext ctx);
	/**
	 * Enter a parse tree produced by the {@code stringExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterStringExpr(MainParser.StringExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code stringExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitStringExpr(MainParser.StringExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code floatExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterFloatExpr(MainParser.FloatExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code floatExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitFloatExpr(MainParser.FloatExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code intExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterIntExpr(MainParser.IntExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code intExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitIntExpr(MainParser.IntExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code logicalExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterLogicalExpr(MainParser.LogicalExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code logicalExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitLogicalExpr(MainParser.LogicalExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code additiveExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterAdditiveExpr(MainParser.AdditiveExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code additiveExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitAdditiveExpr(MainParser.AdditiveExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code boolExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterBoolExpr(MainParser.BoolExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code boolExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitBoolExpr(MainParser.BoolExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code relationalExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterRelationalExpr(MainParser.RelationalExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code relationalExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitRelationalExpr(MainParser.RelationalExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code multiplicativeExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterMultiplicativeExpr(MainParser.MultiplicativeExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code multiplicativeExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitMultiplicativeExpr(MainParser.MultiplicativeExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code parenExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterParenExpr(MainParser.ParenExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code parenExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitParenExpr(MainParser.ParenExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code equalityExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterEqualityExpr(MainParser.EqualityExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code equalityExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitEqualityExpr(MainParser.EqualityExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code idExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterIdExpr(MainParser.IdExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code idExpr}
	 * labeled alternative in {@link MainParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitIdExpr(MainParser.IdExprContext ctx);
}