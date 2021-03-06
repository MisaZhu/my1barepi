/*----------------------------------------------------------------------------*/
#ifndef __MY1I2CH__
#define __MY1I2CH__
/*----------------------------------------------------------------------------*/
#define I2C_SDA1_GPIO 2
#define I2C_SCL1_GPIO 3
#define I2C_SDA_GPIO I2C_SDA1_GPIO
#define I2C_SCL_GPIO I2C_SCL1_GPIO
/*----------------------------------------------------------------------------*/
#define I2C_WAIT_DEFAULT 5
/*----------------------------------------------------------------------------*/
#define I2C_READ_STOP_DISABLE 0
#define I2C_READ_STOP_ENABLE 1
#define I2C_READ_STOP_DEFAULT I2C_READ_STOP_DISABLE
/*----------------------------------------------------------------------------*/
void i2c_init(int sda_gpio, int scl_gpio);
void i2c_set_wait_time(unsigned int wait_time);
void i2c_set_free_time(unsigned int free_time);
void i2c_set_stop_read(int enable);
void i2c_putb(int addr, int regs, int data);
int i2c_getb(int addr, int regs);
int i2c_puts(int addr, int regs, int* pdat, int size);
int i2c_gets(int addr, int regs, int* pdat, int size);
/*----------------------------------------------------------------------------*/
#endif
/*----------------------------------------------------------------------------*/
