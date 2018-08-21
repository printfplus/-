NDD_length = 1e5;
d_NDD = 1e3;
Q_length = 200;
height = 5e-5;
load('final_possi_list_NDD.mat');
NDD_list = final_possi_list(1:NDD_length);
load('final_possi_list_Q.mat');
value_list = final_possi_list(1:Q_length);

NDD_x = 1:NDD_length;
value_x = 1:Q_length;
x1 = NDD_x*d_NDD;
y1 = NDD_list;
x2 = value_x;
y2 = value_list;
hl1 = plot(x1,y1,'Color','r','LineWidth',2);
xlabel('Test Time','FontSize',15);
ylabel('Collision Rate','FontSize',15);
set(gca,'linewidth',2,'FontName','Times New Roman','FontSize',14);
ax1 = gca;
set(ax1,'Xlim',[0,NDD_length*d_NDD],'Ylim',[0,height ])
ax2 = axes('Position',get(ax1,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none');
hl2 = line(x2,y2,'Parent',ax2,'LineWidth',2);
set(ax2,'Xlim',[0,Q_length],'Ylim',[0,height ])
legend([hl1,hl2],'NDD','Value Region');
set(gca,'linewidth',2,'FontName','Times New Roman','FontSize',14);
set(ax2,'ytick',[]);
