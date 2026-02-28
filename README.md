# EMAC Simulation Project

OpenCores tri-eth-mac Verilog verification project with coverage analysis and testcase generation.

## Overview

This project provides a comprehensive verification environment for the OpenCores tri-eth-mac (Triple-Speed Ethernet MAC) IP core.

## Project Structure

```
emac-sim/
├── hdl/                    # RTL source files
│   ├── MAC_top.v          # Top-level MAC module
│   ├── MAC_rx.v           # MAC receiver
│   ├── MAC_tx.v           # MAC transmitter
│   └── ...                # Other modules
├── sim/                    # Simulation environment
│   ├── bfm/               # Bus Functional Models
│   ├── testcase/          # Test cases
│   └── run/               # Simulation outputs
└── sim/filelist/          # File lists
```

## Current Coverage Status

| Metric | Value |
|--------|-------|
| **Branch Coverage** | ~73.6% |
| **Statement Coverage** | ~82.2% |

## Running Simulation

```powershell
cd sim/run
./run.bat
```

## Maintainer

Pan Weitao
