clc
clear all

data = load('proj_fit_39.mat');

%id data
x_id1 = data.id.X{1}; 
x_id2 = data.id.X{2};
y_id = data.id.Y; 

%plotting
%figure;
%mesh(x_id1,x_id2,y_id)
%title("Plot for id data")

N_id1= length(x_id1);
N_id2= length(x_id2);

%validation data
x_val1 = data.val.X{1}; 
x_val2 = data.val.X{2};
y_val = data.val.Y; 

N_val1= length(x_val1);
N_val2= length(x_val2);

%figure;
%mesh(x_val1,x_val2,y_val)
%title("Plot for val data")

%configurable degree m
maxm = 28;
for m = 1:maxm;

    PHI_id = [];
    
    for i = 1:N_id1
        for j = 1:N_id2
            x1 = x_id1(i);
            x2 = x_id2(j);
            phi_vect=[];
    
            for p = 0:m
                for q = 0:m-p
                     phi_vect =  [phi_vect,x1^(p)*x2^(q)]; 
                end
            end
          
            PHI_id =[PHI_id;phi_vect];  
           
        end
    end

    Y_id = y_id.';
    Y_id = Y_id(:);
    
    theta = PHI_id\Y_id;
    y_hat_id = PHI_id*theta;
    
    PHI_val = [];
    
    for i = 1:N_val1
        for j = 1:N_val2
            x1 = x_val1(i);
            x2 = x_val2(j);
            phi_vect=[];
    
            for p = 0:m
                for q = 0:m-p
                     phi_vect =  [phi_vect,x1^(p)*x2^(q)];
                end
            end
          
            PHI_val =[PHI_val;phi_vect];
           
        end
    end
    
    Y_val = y_val.';
    Y_val = Y_val(:);
    y_hat_val = PHI_val*theta;
    
    % MSE
    MSE_id(m) = mean((Y_id - y_hat_id).^2);
    MSE_val(m) = mean((Y_val - y_hat_val).^2);

end

Z_id = reshape(y_hat_id,[N_id2,N_id1]).';

figure;
mesh(x_id1,x_id2,y_id,'EdgeColor', 'b')
hold on;
mesh(x_id1,x_id2,Z_id,'EdgeColor','r')
title("Plot y against id approximation (for m configurable)")
legend("id data plot","id approximation plot")

Z_val= reshape(y_hat_val,[N_val2,N_val1]).';

figure;
mesh(x_val1,x_val2,y_val,'EdgeColor', 'b')
hold on;
mesh(x_val1,x_val2,Z_val,'EdgeColor','r')
title("Plot y against validation appoximation (for m configurable)")
legend("val data plot","val approximation plot");

[mini, n_optim] = min(MSE_val)

figure;
plot(MSE_id,'-o','Color','g');
hold;
plot(MSE_val,'-o','Color','magenta');
hold on;
plot(n_optim,MSE_val(n_optim),'x','Color','r','MarkerSize',20)
legend('MSE id','MSE val','m optim');
xlabel("degree of m");
ylabel("MSE value");

%for n optim

%id data 
PHI_id = [];
    
for i = 1:N_id1
    for j = 1:N_id2
        x1 = x_id1(i);
        x2 = x_id2(j);
        phi_vect=[];
    
        for p = 0:n_optim
            for q = 0:n_optim-p
                phi_vect =  [phi_vect,x1^(p)*x2^(q)]; 
             end
        end
          
        PHI_id =[PHI_id;phi_vect];

    end
end
Y_id = y_id.';
Y_id = Y_id(:);
    
theta = PHI_id\Y_id;
y_hat_id = PHI_id*theta;

%val data
PHI_val = [];
    
for i = 1:N_val1
    for j = 1:N_val2
        x1 = x_val1(i);
        x2 = x_val2(j);
        phi_vect=[];
    
        for p = 0:n_optim
            for q = 0:n_optim-p
                 phi_vect =  [phi_vect,x1^(p)*x2^(q)];
            end
        end
          
        PHI_val =[PHI_val;phi_vect];
           
    end
end
    
Y_val = y_val.';
Y_val = Y_val(:);
y_hat_val = PHI_val*theta;

Z_id = reshape(y_hat_id,[N_id2,N_id1]).';
    
figure;
mesh(x_id1,x_id2,y_id,'EdgeColor', 'b')
hold on;
mesh(x_id1,x_id2,Z_id,'EdgeColor','r')
title("Plot for m optim against id ")
legend("id data plot","id approximation plot for m optim");

Z_val= reshape(y_hat_val,[N_val2,N_val1]).';

figure;
mesh(x_val1,x_val2,y_val,'EdgeColor', 'b')
hold on;
mesh(x_val1,x_val2,Z_val,'EdgeColor','r')
title("Plot for m optim against validation")
legend("val data plot","val approximation plot for m optim");