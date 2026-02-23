 clc
 clear all

load("iddata-05.mat");


u_id = id.u;    
y_id = id.y;     
Ts_id = id.Ts;

u_val = val.u;
y_val = val.y;
Ts_val = val.Ts;

figure;
plot(u_id);
figure;
plot(y_id);

figure;
plot(u_val);
figure;
plot(y_val);


%%

 clc
 clear all

 data = load("iddata-05.mat");
 id_data = data.id;
 val_data = data.val;
 y_id = data.id.y(:);
 u_id = data.id.u(:);

 y_val = data.val.y(:);
 u_val = data.val.u(:);

 figure;
 subplot(2,1,1);
 title("u_id");
 plot(u_id);
 subplot(2,1,2);
 title("y_id");
 plot(y_id);

 figure;
 subplot(2,1,1)
 title("u_val");
 plot(u_val);
 subplot(2,1,2);
 title("y_val");
 plot(y_val);


  N_id = length(y_id);
 N_val = length(y_val);
 

na = 1;
nb = 1;

n = max(na,nb);
rows = N_id - n;

Phi = zeros(rows,na+nb);
Y = zeros(rows,1);

for k = n+1:N_id
    r = k-n;

    for i  = 1:na
        Phi(r,i) = -y_id(k-i);
    end

    for j = 1:nb
        Phi(r,na+j) = u_id(k-j);
    end

    Y(r) = y_id(k);
end

theta = Phi\Y;

%Phi_val calcul 
n = max(na,nb);
rows = N_val - n;

Phi_val = zeros(rows,na+nb);
Y = zeros(rows,1);

for k = n+1:N_val
    r = k-n;

    for i  = 1:na
        Phi_val(r,i) = -y_val(k-i);
    end

    for j = 1:nb
        Phi_val(r,na+j) = u_val(k-j);
    end

    Y(r) = y_val(k);
end


a = theta(1:na);
b = theta(na+1:end);

yhat_id = zeros(N_id,1);

for k = 1:N_id
    s = 0;

    for i = 1:na
        if k-i > 0
            s = s-a(i)*yhat_id(k-i);
        end
    end

    for j = 1:nb
        if k-j > 0
            s = s+b(j)*u_id(k-j);
        end
    end

    yhat_id(k) = s;
end

figure;
plot(y_id,'Color','b');
hold on;
plot(yhat_id,'Color','r');
title("yid vs yhat id")


yhat_val = zeros(N_val,1);

for k = 1:N_val
    s = 0;

    for i = 1:na
        if k-i > 0
            s = s-a(i)*yhat_val(k-i);
        end
    end

    for j = 1:nb
        if k-j > 0
            s = s+b(j)*u_val(k-j);
        end
    end

    yhat_val(k) = s;
end


%predictie


y_pred = Phi_val*theta;

figure;
plot(y_val,'Color','b');
hold on;
plot(yhat_val,'Color','r');
plot(y_pred,'Color','g');
title("yval vs yhat val vs ypred")





nk = 1;
arx_model = arx(id_data,[na nb nk]);

yhat_val_arx = sim(arx_model,val_data);
yhat_val_arx = yhat_val_arx.y(:);