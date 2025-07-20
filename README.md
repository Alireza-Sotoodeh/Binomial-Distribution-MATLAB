# 📊 Binomial Distribution – MATLAB Simulation

A MATLAB-based academic project that explores the **Binomial Distribution** and its approximation by **Normal (Gaussian)** and **Poisson** distributions through statistical analysis and simulation.
<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Binomial_Distribution.svg/960px-Binomial_Distribution.svg.png" alt="Binomial Distribution" width="500"/>
  <br/>
  <em>Figure 1 – Binomial Distribution with p = 0.5 and varying n</em>
</p>


---

## 📘 Overview: What is Binomial Distribution?

The **Binomial Distribution** is a **discrete probability distribution** that models the number of successes in a fixed number of independent **yes/no (Bernoulli)** experiments.

### 🔢 Formula

<p align="center">
  <img src="https://wikimedia.org/api/rest_v1/media/math/render/svg/9ad3f324ca5778bd1cae96fed07ce09063a71a1b" alt="Binomial PMF Formula" width="300"/>
  <br/>
  <em>Figure – Binomial Probability Formula</em>
</p>


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

---

### 📚 Read More

For more theoretical background and mathematical derivations of the Binomial Distribution, visit the full article on [Wikipedia – Binomial Distribution](https://en.wikipedia.org/wiki/Binomial_distribution).

> The page includes properties, formulas, historical context, real-world applications, and relations to other distributions like Poisson and Normal.

---

## 🧑‍🏫 Authors & Credits
- ✍️ Alireza Sotoodeh
- Shahid Bahonar University of Kerman
- 🎓 Supervisor: Dr. Amir Zaimbashi

---

## 📜 License
This project is intended for academic and educational use. Please cite the authors if reusing.
