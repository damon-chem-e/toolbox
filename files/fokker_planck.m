% some parameters
n1 = 50;
n2 = 50;
N = n1*n2;
r = zeros(1,N);
u = zeros(1,N);
d = 0.5;
DD = d.*ones(6,N);
sig = vertcat(3.*ones(1,N),3.*ones(1,N),ones(1,N));
mu = 7.*ones(2,N);
par = struct;
par.ndim = 2;
par.N = N;
par.ns = 2;
par.maxP = 4;
par.tolD = 1.0e-4;
par.dim = [n1,n2];
par.dt = .05;
par.nextr = 10; % this parameter might want to play with

% initial distribution
m = [17,17];
s = [.01,0.01;.01,.01];
x1 = linspace(d,n1*d,n1);
x2 = linspace(d,n2*d,n2);
[X1,X2] = meshgrid(x1,x2); % currently hard-coded for 20 points
X = [X1(:),X2(:)];
Jnow = mvnpdf(X,m,s);
Jnow_plot = reshape(Jnow,length(x1),length(x2));
Jnow = Jnow';

% plot initial distribution
surf(x1,x2,Jnow_plot)
caxis([min(Jnow_plot(:))-0.5*range(Jnow_plot(:)),max(Jnow_plot(:))])
axis([0 25 0 25 0 12.0e8])
xlabel('x1')
ylabel('x2')
zlabel('Initial Probability Density')

% iterate through 2dmap to solve PDE system
for i=1:50
    Jnext = HJBmap2D(DD,Jnow,r,u,mu,sig,par);
    % plot initial distribution
    Jnext_plot = reshape(Jnext,length(x1),length(x2));
    surf(x1,x2,Jnext_plot)
    caxis([min(Jnext_plot(:))-0.5*range(Jnext_plot(:)),max(Jnext_plot(:))])
    axis([0 25 0 25 0 12.0e7])
    xlabel('x1')
    ylabel('x2')
    zlabel('Current Probability Density')
    pause(0.5);
    Jnow = Jnext;
end