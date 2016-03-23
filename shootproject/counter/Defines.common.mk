# ==============================================================================
#
# Defines.common.mk
#
# ==============================================================================


PROG := tm_counter

SRCS += \
	tm_counter.c \
        $(LIB)/thread.c \
#	$(LIB)/bitmap.c \
#	$(LIB)/list.c \
#	$(LIB)/mt19937ar.c \
#	$(LIB)/queue.c \
#	$(LIB)/random.c \
#	$(LIB)/thread.c \
#	$(LIB)/vector.c \
#
OBJS := ${SRCS:.c=.o}

CFLAGS += -DLIST_NO_DUPLICATES
CFLAGS += -DLEARNER_TRY_REMOVE
CFLAGS += -DLEARNER_TRY_REVERSE


# ==============================================================================
#
# End of Defines.common.mk
#
# ==============================================================================
