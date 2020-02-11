# ripple
ripple test

1. Install ubuntu  
2. Install rippled - https://xrpl.org/install-rippled-on-ubuntu.html  
3. Install gnuplot  
4. Run pool.sh: sudo ./pool.sh [SEC_INTERVAL]  
&nbsp;&nbsp;&nbsp;- sudo ./pool.sh .5  
&nbsp;&nbsp;&nbsp;- sudo ./pool.sh 2  
5. Outputs:  
&nbsp;&nbsp;&nbsp;- out.csv - time/sequence  
&nbsp;&nbsp;&nbsp;- stats.txt - min/max/avg  
6. Ctrl-C to stop pool.sh  
7. Run gnuplot (from project dir)  
&nbsp;&nbsp;&nbsp;- load "print.p"  
8. Enjoy !  
