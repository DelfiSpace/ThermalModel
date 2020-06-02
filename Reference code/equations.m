


b(1:length(hc), h) = heat(:,h) - rad +  hc(:) / dt .* t(:,h - 1);

hc/dt * prevT = (heat(:,h) - rad) +  hc(:) / dt .* t(:,h - 1);
prevt - (heat(:,h) - rad)* dt / hc - t(:,h-1) = 0

prevt = (heat - rad) * dt / hc + t(:, h-1)
prevt - (heat - sigma*epls*A*prevt^4) * dt / hc - t(h-1) = 0

solution:
prevt = prevt(n-1) - (prevt(n-1) - (heat - sigma*eps*A*prevt^4) * dt / hc - t(h-1)) / (1 + 4*sigma*eps*A*prevt^3*dt/hc)

hc/dt*prevt = hc/dt*prevt(n-1) - (prevt(n-1)*hc/dt - heat +  sigma*eps*A*prevt^4 - t(h-1)*hc/dt) / (1+4*sigma*eps*A*prevt^3*dt/hc)




delta = (sigma * A .* prevt.^4 + hc(1:6) / dt .* prevt - heat(1:6,h) - t(h - 1) * hc(1:6) / dt) ...
            / (4 * sigma * A * prevt.^3 + hc(1:6) / dt);
        