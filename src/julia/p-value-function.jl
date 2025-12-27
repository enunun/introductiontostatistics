using Distributions
using Plots

# -----------------------------
# パラメータ
# -----------------------------
n = 20          # 試行回数
k = 14          # 観測された成功回数
α = 0.05        # 有意水準
# p の範囲
p_vals = range(0.001, 0.999, length=500)

# -----------------------------
# p値関数
# -----------------------------

function p_value_two_sided(p)
    dist = Binomial(n, p)
    prob = pdf(dist, k)
    sum(pdf(dist, i) for i in 0:n if pdf(dist, i) ≤ prob)
end

p_value(p) = 1 - cdf(Binomial(n, p), k - 1)

#pvals = [p_value(p) for p in p_vals]

pvals = [p_value_two_sided(p) for p in p_vals]

# -----------------------------
# プロット
# -----------------------------
plot(
    p_vals,
    pvals,
    xlabel = "p",
    ylabel = "p-value",
    title = "Binomial test p-value function (n=$n, k=$k)",
    linewidth = 2,
	color = :black,
    legend = false,
)
# 有意水準の水平線
hline!(
    [α],
    linestyle = :dash,
    linewidth = 2,
	color = :black,
    label = "α = $α"
)
savefig("p-value-function.svg")