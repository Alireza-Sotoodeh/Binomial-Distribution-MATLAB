# 📊 Binomial Distribution – MATLAB Simulation

A MATLAB-based academic project that explores the **Binomial Distribution** and its approximation by **Normal (Gaussian)** and **Poisson** distributions through statistical analysis and simulation.

---

## 📘 Overview: What is Binomial Distribution?

The **Binomial Distribution** is a **discrete probability distribution** that models the number of successes in a fixed number of independent **yes/no (Bernoulli)** experiments.

### 🔢 Formula

\[
P(X = k) = \binom{n}{k} \cdot p^k \cdot (1 - p)^{n-k}
\]

Where:
- \( n \): number of trials
- \( k \): number of successes
- \( p \): probability of success
- \( q = 1 - p \): probability of failure

### 🔄 Parameter Effects

| Parameter | Effect |
|----------|--------|
| **n (number of trials)** | Larger `n` makes the distribution smoother and suitable for approximation. |
| **p (probability of success)** | Affects skewness. `p = 0.5` is symmetric. |
| **q = 1 - p** | Affects spread and shape of the distribution. |

---

## 🧠 About the Project

This project simulates the **Binomial distribution** in MATLAB and compares it with:

- **Normal distribution** (used when `np ≥ 5` and `nq ≥ 5`)
- **Poisson distribution** (used when `np ≤ 2`)

Includes visual validation using multiple test cases.

---

## 📄 Contents

- `report.pdf` – Detailed report explaining the theory and findings.
- `binomial_simulation.m` – MATLAB script to:
  - Compute binomial PMF
  - Overlay Poisson & Normal approximations
  - Visualize results



---

## 🛠️ How to Run

1. Open MATLAB and run the script:
   ```matlab
   binomial_simulation.m

## 🧑‍🏫 Authors & Credits
- ✍️ Alireza Sotoodeh
- Shahid Bahonar University of Kerman
- 🎓 Supervisor: Dr. Amir Zaimbashi

## 📜 License
This project is intended for academic and educational use. Please cite the authors if reusing.
