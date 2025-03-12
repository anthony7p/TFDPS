function ECG = normalizacion(t,x_fil)
    [p,s,mu] = polyfit(t,x_fil,9);
    tendencia = polyval(p,t,[],mu);
    ECG = x_fil-tendencia;
end