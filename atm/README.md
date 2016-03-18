# ATM : Application Thread Monitoring

## 1 - Preamble

This programm helps you to analyze precisely what are the status of all the threads created, and ran by your application.
We focus our attention on:

- Thread Priority
- Thread Nice Priority
- Thread Real Time Priority
- Thread Name
- Thread ID
- Thread Scheduling Policy
- Thread State
- Processor on which the thread is executed

## 2 - How it works ?

What you need to know first is that, if you want to have a specific information about the state of 
your Linux system go to */proc*. Normally everything is there and it's what we do with ATM.
We parse some files in /proc to get the information we want.
If you want to have all the details about /proc go to http://man7.org/linux/man-pages/man5/proc.5.html

## 3 - How to use it ?

## 4 - Credits

- Thierry BADJI @khalebios
- Boris BIGNUMB-BI-KUMB @bigNUMB

