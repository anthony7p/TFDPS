function [X,FREC] = fourier(x,Fs)

    M= length(x);  %Cuál es el tamaño del bloque de entrada
    n_m = 2^nextpow2(M);

    X = fft(x,n_m);

    X = X(1:n_m/2+1);  %Región de interés de 0-pi
    d_f = Fs/n_m;  %Resolución de la frecuencia

    FREC = 0:d_f:d_f*(n_m/2);  %Vector Frecuencias

end