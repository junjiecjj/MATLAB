function ura_sv = URA_sv(theta, phi,Nx,Ny)
    m = 0:Nx-1;
    a_az = exp(1i*pi*m*sin(theta)*cos(phi)).';
    n = 0:Ny-1;
    a_el = exp(1i*pi*n*sin(phi)).';
    ura_sv = kron(a_az,a_el);
end
