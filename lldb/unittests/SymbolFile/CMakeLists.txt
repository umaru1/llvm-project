add_subdirectory(DWARF)
add_subdirectory(NativePDB)
if (LLVM_ENABLE_DIA_SDK)
  add_subdirectory(PDB)
endif()
