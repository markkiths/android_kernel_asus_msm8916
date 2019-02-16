/*
 * Definitions for tfa9887 speaker amp chip.
 */
#ifndef TFA9887_H
#define TFA9887_H

#include <linux/ioctl.h>

#define TFA9887_I2C_NAME	"tfa9887"
#define TFA9887L_I2C_NAME	"tfa9887l"

#define TFA9887_IOCTL_MAGIC	'a'
#define TFA9887_WRITE_CONFIG	_IOW(TFA9887_IOCTL_MAGIC, 0x01, unsigned int)
#define TFA9887_READ_CONFIG	_IOW(TFA9887_IOCTL_MAGIC, 0x02, unsigned int)
#define TFA9887_ENABLE_DSP	_IOW(TFA9887_IOCTL_MAGIC, 0x03, unsigned int)
#define TFA9887_WRITE_L_CONFIG	_IOW(TFA9887_IOCTL_MAGIC, 0x04, unsigned int)
#define TFA9887_READ_L_CONFIG	_IOW(TFA9887_IOCTL_MAGIC, 0x05, unsigned int)
#define TFA9887_KERNEL_LOCK	_IOW(TFA9887_IOCTL_MAGIC, 0x06, unsigned int)
#define TFA9887_KERNEL_INIT	_IOW(TFA9887_IOCTL_MAGIC, 0x07, unsigned int)
#define TFA9887_SET_SPKAMP	_IOW(TFA9887_IOCTL_MAGIC, 0x08, unsigned int)

#define ACOUSTIC_IOCTL_MAGIC 'p'
#define ACOUSTIC_SET_Q6_EFFECT          _IOW(ACOUSTIC_IOCTL_MAGIC, 43, unsigned)
#define ACOUSTIC_GET_HTC_REVISION       _IOW(ACOUSTIC_IOCTL_MAGIC, 44, unsigned)
#define ACOUSTIC_GET_HW_COMPONENT       _IOW(ACOUSTIC_IOCTL_MAGIC, 45, unsigned)
#define ACOUSTIC_GET_DMIC_INFO          _IOW(ACOUSTIC_IOCTL_MAGIC, 46, unsigned)
#define ACOUSTIC_UPDATE_BEATS_STATUS    _IOW(ACOUSTIC_IOCTL_MAGIC, 47, unsigned)
#define ACOUSTIC_UPDATE_LISTEN_NOTIFICATION     _IOW(ACOUSTIC_IOCTL_MAGIC, 48, unsigned)
#define ACOUSTIC_GET_HW_REVISION        _IOR(ACOUSTIC_IOCTL_MAGIC, 49, struct device_info)
#define ACOUSTIC_CONTROL_WAKELOCK       _IOW(ACOUSTIC_IOCTL_MAGIC, 77, unsigned)
#define ACOUSTIC_DUMMY_WAKELOCK         _IOW(ACOUSTIC_IOCTL_MAGIC, 78, unsigned)
#define ACOUSTIC_AMP_CTRL               _IOR(ACOUSTIC_IOCTL_MAGIC, 50, unsigned)
#define ACOUSTIC_GET_MID                _IOW(ACOUSTIC_IOCTL_MAGIC, 51, unsigned)
#define ACOUSTIC_RAMDUMP                _IOW(ACOUSTIC_IOCTL_MAGIC, 99, unsigned)
#define ACOUSTIC_KILL_PID               _IOW(ACOUSTIC_IOCTL_MAGIC, 88, unsigned)
#define ACOUSTIC_UPDATE_DQ_STATUS       _IOW(ACOUSTIC_IOCTL_MAGIC, 52, unsigned)

#define AUD_AMP_SLAVE_ALL       0xffff

#ifdef __KERNEL__
struct tfa9887_platform_data {
	uint32_t gpio_tfa9887_spk_en;
};
#endif

enum ACOU_AMP_CTRL {
        AMP_READ = 0,
        AMP_WRITE,
};

enum AMP_TYPE {
        AMP_HEADPONE = 0,
        AMP_SPEAKER,
        AMP_RECEIVER,
};

struct amp_ctrl {
        enum ACOU_AMP_CTRL ctrl;
        enum AMP_TYPE type;
        unsigned short slave;
        unsigned int reg;
        unsigned int val;
};

//int set_tfa9887_spkamp(int en, int dsp_mode);
//int set_tfa9887l_spkamp(int en, int dsp_mode);
int tfa9887_l_write(char *txData, int length);
int tfa9887_l_read(char *rxData, int length);
#endif
