*******************************************************************
*   System-defined Include-files.                                 *
*******************************************************************
  INCLUDE lzpdbctop.                         " Global Declarations
  INCLUDE lzpdbcuxx.                         " Function Modules

*******************************************************************
*   User-defined Include-files (if necessary).                    *
*******************************************************************
  INCLUDE lzpdbcf00 IF FOUND.                " Subroutines
  INCLUDE lzpdbco00 IF FOUND.                " PBO-Modules
  INCLUDE lzpdbci00 IF FOUND.                " PAI-Modules
  INCLUDE lzpdbce00 IF FOUND.                " Events
  INCLUDE lzpdbcp00 IF FOUND.                " Local class implement.
  INCLUDE lzpdbct99 IF FOUND.                " ABAP Unit tests
