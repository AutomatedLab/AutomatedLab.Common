using System;

namespace Pki
{
    public static class Period
    {
        public static TimeSpan ToTimeSpan(byte[] value)
        {
            var period = BitConverter.ToInt64(value, 0); period /= -10000000;
            return TimeSpan.FromSeconds(period);
        }

        public static byte[] ToByteArray(TimeSpan value)
        {
            var period = value.TotalSeconds;
            period *= -10000000;
            return BitConverter.GetBytes((long)period);
        }
    }
}
