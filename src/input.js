`${((strings, ...values) => {
    const state = {};
    const script = strings.reduce(
        (acc, str, i) =>
            acc + str +
            (values[i] !== undefined
                ? JSON.stringify(values[i])
                : ""),
        ""
    );

    script.trim().split("\n").forEach(line => {
        const parts = line.trim().split(" ");
        const cmd = parts[0];
        const key = parts[1];
        const val = parts[2];

        if (cmd === "SET") {
            state[key] = Number(val);
        }

        if (cmd === "ADD") {
            state[key] = (state[key] || 0) + Number(val);
        }
    });

    return state.gold;
})`SET gold ${100}
ADD gold ${50}`}`