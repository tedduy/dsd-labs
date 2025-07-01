# Digital System Design Labs – Truong Buu Duy

This repository contains lab exercises and project components for the **Digital System Design (DSD)** course, implemented using **Verilog/VHDL** and synthesized using **Intel Quartus**. Functional simulations were performed with **ModelSim**.

---

## 📄 Lab Reports (PDF)

All lab handouts and instructions are available in the following Google Drive folder:

🔗 [View Lab Documents](https://drive.google.com/drive/u/0/folders/1FRRgC0Tlp77hkjLiys7ZN0PdatpyIWiU)

These include:
- Lab1: Basic Combinational Logic Circuits
- Lab2: More Combinational and Sequential Logic
- Lab3: Sequential Logic Circuits
- Lab4: Basic Circuits using VHDL
- Lab5: Building Blocks of Single-Cycle Processor
- Lab6: 16-bit Single-Cycle Processor Architecture

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

---

## ⬇️ Download This Repository

To download all files in this repository as a ZIP file:

1. Click the green **`Code`** button near the top-right.
2. Select **`Download ZIP`**.
3. Extract the file to view all lab folders and components.

📁 The ZIP file will include:
- Lab1 to Lab6: Verilog/VHDL designs, simulations
- `TruongBuuDuy_ITITIU21188_DSD_Project/`: Final project (16-bit processor)

Alternatively, you can clone the repo using Git:

```bash
git clone https://github.com/tedduy/dsd-labs.git

