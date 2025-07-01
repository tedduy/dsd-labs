# Digital System Design Labs – Truong Buu Duy

This repository contains lab exercises and project components for the **Digital System Design (DSD)** course, implemented using **Verilog/VHDL** and synthesized using **Intel Quartus**. Functional simulations were performed with **ModelSim**.

---

## 📁 Directory Structure

Lab1/
  Ex1/ to Ex7/   – 🔧 Basic combinational and sequential circuits (Part 1)

Lab2/
  Ex1/ to Ex8/   – 🔧 Basic combinational and sequential circuits (Part 2)

Lab3/
  Ex1/ to Ex11/  – 🔁 Sequential logic circuits (Flip-Flops, Registers, Counters, etc.)

Lab4/
  Ex1/ to Ex10/  – 💡 Combinational & sequential circuits using VHDL (Behavioral, Dataflow, Gate-level)

Lab5/
  Ex1/ to Ex10/  – 🧱 Fundamental building blocks of a single-cycle processor 
                  (ALU, PC, Register File, Instruction/Data Memory, etc.)

Lab6/
  Ex1/ to Ex11/  – 🖥️ Complete 16-bit single-cycle processor architecture 
                  (including datapath integration and instruction execution)

TruongBuuDuy_ITITIU21188_DSD_Project/
├── 16bit_Single_Cycle_Processor/   – 🧠 Top-level RTL implementation of processor
└── Components/                     – 🧩 Modular components: ALU, Register File, etc.


## 🛠️ Tools Used

- **Quartus II 9.0** (design, synthesis)
- **ModelSim ** (simulation)
- **Verilog/VHDL** (design language)
- **FPGA target**: Intel Cyclone II (DE2 board)

---

## 📌 Notes

- All synthesis-related output folders (e.g., `db/`, `incremental_db/`, `simulation/rtl_work/`) are ignored via `.gitignore`.
- Each exercise includes at least:  
  - Source code (`.v` / `.sv`)  
  - Constraints (`.sdc`)  
  - Testbenches (`*_tb.v`)  
  - Block diagram (where applicable)

---

## 📜 License

This project is licensed under the **MIT License**. See the `LICENSE` file for more details.
