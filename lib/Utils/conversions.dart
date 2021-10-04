import 'dart:math';
import 'package:intl/intl.dart';

class Conversions
{

  static String formatBytes(int? bytes, int decimals) {
    if (bytes != null) {
      if (bytes <= 0) return "0 B";
      const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (log(bytes) / log(1024)).floor();
      return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
          ' ' +
          suffixes[i];
    } else {
      return 'Error';
    }
  }

  static String intToSpeed(int? bytes) {
    if (bytes != null) {
      if (bytes <= 0) return "0 Bps";
      const suffixes = ["Bps", "KBps", "MBps", "GBps", "TBps", "PBps", "EBps", "ZBps", "YBps"];
      var i = (log(bytes) / log(1024)).floor();
      return ((bytes / pow(1024, i)).toStringAsFixed(0)) +
          ' ' +
          suffixes[i];
    } else {
      return 'Error';
    }
  }

  static String timeStampToDate(int? timeStamp) {
    if (timeStamp!=null){
      var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      return DateFormat('dd/MM/yyyy hh:mm a').format(dateToTimeStamp);
    } else {
      return "Error Loading Time";
    }
  }

  static String progressToPercentage(double? progress){
    if (progress==null){
      return "Error";
    } else if (progress == 1) {
      return "100%";
    } else {
      return (progress*100).toStringAsFixed(1)+"%";
    }
  }

  // static double humanSizeToBytes(String value)
  // {
  //   String scalar;
  //   int unit = 1024;
  //   int exp;
  //   int c;
  //   double returnValue = 0;
  //   List<String> words = value.split("\\s+");
  //   if (words.length == 2) {
  //     try {
  //       scalar = words[0].replace(",", ".");
  //       exp = "BKMGTPE".indexOf(words[1].toCharArray()[0]);
  //       returnValue = (Double.parseDouble(scalar) * Math.pow(unit, exp));
  //     } on Exception catch (e) {
  //       returnValue = 0;
  //     }
  //   }
  //   return returnValue;
  // }

  // static String unixTimestampToDate(String unixDate)
  // {
  //   int dv = (int.parse(unixDate) * 1000);
  //   Date df = new Date(dv);
  //   var format = DateFormat()
  //   return new SimpleDateFormat("yyyy-MM-dd hh:mm a").format(df);
  // }



  // static String unixTimestampToDate(int unixDate)
  // {
  //   Date df = new Date(unixDate);
  //   return new SimpleDateFormat("yyyy-MM-dd hh:mm a").format(df);
  // }
  //
  // static String secondsToEta(int seconds)
  // {
  //   String secs = "∞";
  //   int day = TimeUnit.SECONDS.toDays(seconds);
  //   int hours = (TimeUnit.SECONDS.toHours(seconds) - (day * 24));
  //   int minute = (TimeUnit.SECONDS.toMinutes(seconds) - (TimeUnit.SECONDS.toHours(seconds) * 60));
  //   int second = (TimeUnit.SECONDS.toSeconds(seconds) - (TimeUnit.SECONDS.toMinutes(seconds) * 60));
  //   if (day >= 100) {
  //     secs = "∞";
  //   } else {
  //     if (day > 0) {
  //       secs = (((day + "d ") + hours) + "h");
  //     } else {
  //       if (hours > 0) {
  //         secs = (((hours + "h ") + minute) + "m");
  //       } else {
  //         if (minute > 0) {
  //           secs = (minute + "m");
  //         } else {
  //           secs = (second + "s");
  //         }
  //       }
  //     }
  //   }
  //   return secs;
  // }
  //
  // static String timestampToDate(String timestamp)
  // {
  //   int unixtimestamp = new Long(timestamp);
  //   if (unixtimestamp == Long_.parseLong("4294967295")) {
  //     return "";
  //   }
  //   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH:mm");
  //   Date date = new Date(unixtimestamp * 1000);
  //   return new SimpleDateFormat("yyyy-MM-dd hh:mm a").format(date);
  // }
  //
  // static String timestampToDate(int unixtimestamp)
  // {
  //   if (unixtimestamp == Long_.parseLong("4294967295")) {
  //     return "";
  //   }
  //   Date date = new Date(unixtimestamp * 1000);
  //   return new SimpleDateFormat("yyyy-MM-dd hh:mm a").format(date);
  // }
  //
  // static List<int> fullyReadFileToBytes(File f)
  // {
  //   int size = f.length;
  //   List<int> bytes = new List<int>(size);
  //   List<int> tmpBuff = new List<int>(size);
  //   FileInputStream fis = new FileInputStream(f);
  //   try {
  //     int read = fis.read(bytes, 0, size);
  //     if (read < size) {
  //       int remain = (size - read);
  //       while (remain > 0) {
  //         read = fis.read(tmpBuff, 0, remain);
  //         System.arraycopy(tmpBuff, 0, bytes, size - remain, read);
  //         remain -= read;
  //       }
  //     }
  //   } finally {
  //     fis.close();
  //   }
  //   return bytes;
  // }
  //
  // static String ProgressForUi(double progress)
  // {
  //   DecimalFormat df = new DecimalFormat("0.00");
  //   df.setRoundingMode(RoundingMode.DOWN);
  //   return df.format(progress * 100);
  // }
  //
  // static String ProgressForUiTruncated(double progress)
  // {
  //   DecimalFormat df = new DecimalFormat("0");
  //   df.setRoundingMode(RoundingMode.DOWN);
  //   return df.format(progress * 100);
  // }
  //
  // static String RatioForUi(double ratio)
  // {
  //   DecimalFormat df = new DecimalFormat("0.00");
  //   df.setRoundingMode(RoundingMode.DOWN);
  //   return df.format(ratio);
  // }
  //
  // static List<int> getBytes(InputStream inputStream)
  // {
  //   ByteArrayOutputStream byteBuffer = new ByteArrayOutputStream();
  //   int bufferSize = 1024;
  //   List<int> buffer = new List<int>(bufferSize);
  //   int len;
  //   while ((len = inputStream.read(buffer)) != (-1)) {
  //     byteBuffer.write(buffer, 0, len);
  //   }
  //   return byteBuffer.toByteArray();
  // }
}