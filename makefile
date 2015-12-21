# common makefile to generate raspberry pi bare-metal code (kernel.img)

ifeq ($(OS),Windows_NT)
TOOLPATH ?= /c/users/public/tool/xtool-arm/bin/
else
TOOLPATH ?= /home/share/tool/xtool-arm/bin/
endif
TOOLPFIX ?= $(TOOLPATH)arm-none-eabi

# multiple source files (list them here as object files!)
OBJLST ?= boot.o main.o

LINKER ?= kernel.ld
TARGET ?= kernel.img
LST ?= kernel.lst
MAP ?= kernel.map

AFLAGS +=
CFLAGS += -O2 -mfpu=vfp -mfloat-abi=hard
CFLAGS += -march=armv6zk -mtune=arm1176jzf-s
CFLAGS += -nostdlib -nostartfiles -ffreestanding
LFLAGS += --no-undefined

# prevent make from automatically removing these!
TEMPS = $(patsubst src/%.s,%.o,$(wildcard src/*.s))
TEMPS += $(patsubst src/%.s,%.elf,$(wildcard src/*.s))
TEMPS += $(patsubst src/%.c,%.o,$(wildcard src/*.c))
TEMPS += $(patsubst src/%.c,%.elf,$(wildcard src/*.c))
.SECONDARY: $(TEMPS)

info:
	@echo "Go to respective folders to build the tutorial code(s) you need!"

pi: $(TARGET)

clean:
	rm -rf *.img *.elf *.lst *.map *.o

new: clean pi

$(TARGET): main.elf
	$(TOOLPFIX)-objcopy $< -O binary $@

%.elf: $(OBJLST)
	$(TOOLPFIX)-ld $(LFLAGS) $^ -Map $(MAP) -o $@ -T $(LINKER)
	$(TOOLPFIX)-objdump -d $@ > $(LST)

%.o: src/%.s
	$(TOOLPFIX)-as $(AFLAGS) $< -o $@

%.o: src/%.c src/%.h
	$(TOOLPFIX)-gcc $(CFLAGS) -c $< -o $@

%.o: src/%.c
	$(TOOLPFIX)-gcc $(CFLAGS) -c $< -o $@
