#ifndef __GDB_TM_PPC_MACOSX_H__
#define __GDB_TM_PPC_MACOSX_H__

#ifndef GDB_MULTI_ARCH
#define GDB_MULTI_ARCH 1
#endif

int ppc_fast_show_stack (int show_frames, int show_names, int limit, int *count, 
			 void (print_fun) (struct ui_out *uiout, int frame_num, 
					   CORE_ADDR pc, CORE_ADDR fp));
#define FAST_COUNT_STACK_DEPTH(show_frames, get_names, limit, count, print_fun) \
    (ppc_fast_show_stack (show_frames, get_names, limit, count, print_fun))

#endif /* __GDB_TM_PPC_MACOSX_H__ */
