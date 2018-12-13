import { ConcolicValue } from "../Values/WrappedValue";

export default function(state, ctx, model, helpers) {

	const symbolicHook = helpers.symbolicHook;
	const symbolicSubstring = helpers.substring;
	const coerceToString = helpers.coerceToString;

	/**
	 * Stubs string constructor with our (flaky) coerceToString fn
	 */
	model.add(String, symbolicHook(
		String,
		(_base, args) => state.isSymbolic(args[0]),
		(_base, args, _result) => coerceToString(args[0])
	));

	const substrModel = symbolicHook(
		String.prototype.substr,
		(base, args) => typeof state.getConcrete(base) === "string"
			&& (state.isSymbolic(base) || state.isSymbolic(args[0]) || state.isSymbolic(args[1])),
		symbolicSubstring
	);

	model.add(String.prototype.substr, substrModel);
	model.add(String.prototype.substring, substrModel);
	model.add(String.prototype.slice, substrModel);

	model.add(String.prototype.charAt, symbolicHook(
				String.prototype.charAt,
				(base, args) => {
				const is_symbolic = (state.isSymbolic(base) || state.isSymbolic(args[0]));
				const is_well_formed = typeof state.getConcrete(base) === "string" && typeof state.getConcrete(args[0]) === "number";
				return is_symbolic && is_well_formed;
				},
				(base, args, result) => {
				const index_s = ctx.mkRealToInt(state.asSymbolic(args[0]));
				const char_s = ctx.mkSeqAt(state.asSymbolic(base), index_s);
				return new ConcolicValue(result, char_s);
				}
				));

	model.add(String.prototype.concat, symbolicHook(
				String.prototype.concat,
				(base, args) => state.isSymbolic(base) || find.call(args, arg => state.isSymbolic(arg)),
				(base, args, result) => {
				const arg_s_list = Array.prototype.map.call(args, arg => state.asSymbolic(arg));
				const concat_s = ctx.mkSeqConcat([state.asSymbolic(base)].concat(arg_s_list));
				return new ConcolicValue(result, concat_s);
				}
				));

	model.add(String.prototype.indexOf, symbolicHook(
				String.prototype.indexOf,
				(base, args) => typeof state.getConcrete(base) === "string" && (state.isSymbolic(base) || state.isSymbolic(args[0]) || state.isSymbolic(args[1])),
				(base, args, result) => {
				const off_real = args[1] ? state.asSymbolic(args[1]) : state.asSymbolic(0);
				const off_s = ctx.mkRealToInt(off_real);
				const target_s = state.asSymbolic(coerceToString(args[0]));
				const seq_index = ctx.mkSeqIndexOf(state.asSymbolic(base), target_s, off_s);
				return new ConcolicValue(result, seq_index);
				}
				));

	model.add(String.prototype.repeat, symbolicHook(
				String.prototype.repeat,
				(base, a) => state.isSymbolic(base) || state.isSymbolic(a[0]) 
				&& typeof(state.getConcrete(base)) == "string"
				&& typeof(state.getConcrete(a[0])) == "number",
				(base, a, result) => {

				const num_repeats = state.asSymbolic(a[0]);
				state.pushCondition(ctx.mkGe(num_repeats, ctx.mkIntVal(0)));

				const result_s = ctx.mkApp(state.stringRepeat, [state.asSymbolic(base), ctx.mkRealToInt(num_repeats)]);
				return new ConcolicValue(result, result_s); 
				}
				));

	function trimLeftSymbolic(base_s) {
		const whiteLeft = ctx.mkApp(state.whiteLeft, [base_s, ctx.mkIntVal(0)]);
		const strLen = base_s.getLength();
		const totalLength = ctx.mkSub(strLen, whiteLeft);
		return ctx.mkSeqSubstr(base_s, whiteLeft, totalLength);
	}

	function trimRightSymbolic(base_s) {
		const strLen = base_s.getLength();
		const whiteRight = ctx.mkApp(state.whiteRight, [base_s, strLen]);
		const totalLength = ctx.mkAdd(whiteRight, ctx.mkIntVal(1));
		return ctx.mkSeqSubstr(base_s, ctx.mkIntVal(0), totalLength);
	}

	model.add(String.prototype.trimRight, symbolicHook(
				String.prototype.trim,
				(base, _a) => state.isSymbolic(base) && typeof(state.getConcrete(base).valueOf()) === "string",
				(base, _a, result) => {
				const base_s = state.asSymbolic(base);
				return new ConcolicValue(result, trimRightSymbolic(base_s));
				}
				));

	model.add(String.prototype.trimLeft, symbolicHook(
				String.prototype.trim,
				(base, _a) => state.isSymbolic(base) && typeof(state.getConcrete(base).valueOf()) === "string",
				(base, _a, result) => {
				const base_s = state.asSymbolic(base);
				return new ConcolicValue(result, trimLeftSymbolic(base_s));
				}
				));

	model.add(String.prototype.trim, symbolicHook(
				String.prototype.trim,
				(base, _a) => state.isSymbolic(base) && typeof(state.getConcrete(base).valueOf()) === "string",
				(base, _a, result) => {
				const base_s = state.asSymbolic(base);
				return new ConcolicValue(result, trimRightSymbolic(trimLeftSymbolic(base_s)));
				}
				));

	model.add(String.prototype.toLowerCase, symbolicHook(
				String.prototype.toLowerCase,
				(base, _a) => state.isSymbolic(base) && typeof(state.getConcrete(base).valueOf()) === "string",
				(base, _a, result) => {
				base = coerceToString(base);

				state.pushCondition(
						ctx.mkSeqInRe(state.asSymbolic(base),
							Z3.Regex(ctx, /^[^A-Z]+$/).ast),
						true
						);

				return new ConcolicValue(result, state.asSymbolic(base));
				}
				));

}
