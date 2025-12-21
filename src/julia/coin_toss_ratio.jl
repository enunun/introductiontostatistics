using Random, Plots

Ns = [10, 30, 100, 300, 1_000, 3_000, 10_000]
Random.seed!(4321)

ratios = map(N -> sum(rand(Bool, N)) / N, Ns)

# 数値ラベル（小数4桁）
labels = string.(round.(ratios; digits = 4))

Plots.font("Sans", 1)

plot(
    Ns,
    ratios,
    xscale = :log10,
    color = :black,
    linewidth = 2,
    linestyle = :solid,
    marker = :circle,
    markercolor = :white,
    markerstrokecolor = :black,
    series_annotations = [(labels[i], :bottom) for i in eachindex(labels)],
    xlabel = "toss count",
    ylabel = "head ratio",
    legend = false,
    ylim = (0, 1),
	guidefontsize = 12,
	tickfontsize = 12,
	margin=5Plots.mm,
    framestyle = :box,
)

savefig("coin_toss_ratio.svg")