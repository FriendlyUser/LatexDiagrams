## Latex Diagrams
This repo contains all the diagrams I have generated for my academic career at the University Of Victoria.

# ControlSystems

![ControlSystems](ControlSystems/460A3SamplerTesting.png?raw=true "460A3SamplerTesting")

```tex

\documentclass{standalone}
\usepackage{tikz}
\usetikzlibrary{positioning}
\usetikzlibrary{shapes,arrows,calc} 
\usetikzlibrary{decorations.text}
\tikzset{add/.style n args={4}{
		minimum width=6mm,
		path picture={
			\draw[black] 
			(path picture bounding box.south east) -- (path picture bounding box.north west)
			(path picture bounding box.south west) -- (path picture bounding box.north east);
			\node at ($(path picture bounding box.south)+(0,0.13)$)     {\tiny #1};
			\node at ($(path picture bounding box.west)+(0.13,0)$)      {\tiny #2};
			\node at ($(path picture bounding box.north)+(0,-0.13)$)        {\tiny #3};
			\node at ($(path picture bounding box.east)+(-0.13,0)$)     {\tiny #4};
		}
	}
}
\begin{document}
	
%\begin{figure}
%\centering
	\tikzstyle{block} = [draw, fill=blue!20, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{controller} = [draw, fill=red!20, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{sum} = [draw, fill=blue!20, circle, node distance=1cm]
	\tikzstyle{input} = [coordinate]
	\tikzstyle{output} = [coordinate]
	\tikzstyle{sampleSP} = [coordinate]
	\tikzstyle{sampleEP} = [coordinate]
	\tikzstyle{otherPoint} = [coordinate]
	\begin{tikzpicture}[auto, >=latex']
	% Nodes
	\node [input] (input) {};
	%\node [sum, right = 1cm of input] (sum) {};
	\node[draw,circle,add={--}{+}{}{},right of= input](sum){}; 
	\node [sampleSP, right = 1cm of sum] (sumSP) {};
	\node [sampleEP, right = 1cm of sumSP] (sumEP) {};
	\node [sampleEP, above = 1cm of sumEP] (sumEPTOP) {};
	\node [controller, right = 2cm of sumEP] (system) {$G(s)$};
	\node [otherPoint,right = 1cm of system] (branchPoint) {};
	\node [otherPoint,below = 1 cm of system] (belowsystem) {}; %{$\frac{1}{Ts+1}$};
	%\node [block, right = 1cm of system] (system2) {$\frac{1}{Ts+1}$};
	\node [output, right = 2cm of branchPoint] (output) {};
	%\node [input, below = 0.5cm of system] (m) {};
	\node [block, right = 0.75 of belowsystem] (systemH) {$H_1(s)$};
	
	% Second Sampler Point
	\node [sampleSP, left = 1cm of systemH] (sysHSP2) {};
	\node [sampleEP, left = 1cm of sysHSP2] (sysHEP2) {};
	\node [sampleEP, above = 1cm of sysHEP2] (sumEPTOP2) {};
	
	% Second block 
	\node [block, left = 1.5cm of sysHEP2] (systemH2) {$H_2(s)$};
	% Arrows
	\draw [draw,->] (input) -- node {$R$} (sum);
	% Arrows for first sampler
	\draw [-] (sum) -- node {$E(s)$} (sumSP);
	\draw [-,thick] (sumEPTOP) -- node {$\delta_\tau$} (sumSP);
	\draw [->] (sumEP) -- node {$E^\ast(s)$} (system);
	%Arrows for second sampler (bottom)
	\draw [-]  (sysHSP2)-- node {$M(s)$} (systemH);  
	\draw [-,thick] (sysHSP2) -- node {$\delta_\tau$} (sumEPTOP2);
	%\draw [->] (sumEP) -- node {$M^\ast(s)$} (systemH);
	% \draw [->] (system) --  (system2);
	\draw [-] (system) --  (branchPoint);
	\draw [->] (branchPoint) -- node (y) {$C(s)$}(output);
	\draw [-] (y) |- (systemH) {};
	%\draw [-] (y) |- (m) {} ;
	\draw [<-] (systemH2) -- node {$M^\ast(s)$} (sysHEP2);
	\draw [->] (systemH2) -| (sum); %{$-$}  node [near end] {} (sum);
	%\draw [->] (m) -| node[pos=0.99] {} node [near end] {} (sum); %{$-$}  node [near end] {} (sum);
	\end{tikzpicture}
%\end{figure}
\end{document}
```
# ControlSystems/CSII

![ControlSystems/CSII](ControlSystems/CSII/B4-8.png?raw=true "B4-8")

```tex

\documentclass[%
% border=1pt
border={-25pt 0pt 0pt 0pt} % left bottom right top
]{standalone}
\usepackage{amsmath}
\usepackage{tikz}
\usetikzlibrary{positioning}
\usetikzlibrary{shapes,arrows,calc} 
\usetikzlibrary{decorations.text}
\tikzset{add/.style n args={4}{
		minimum width=6mm,
		path picture={
			\draw[black] 
			(path picture bounding box.south east) -- (path picture bounding box.north west)
			(path picture bounding box.south west) -- (path picture bounding box.north east);
			\node at ($(path picture bounding box.south)+(0,0.13)$)     {\tiny #1};
			\node at ($(path picture bounding box.west)+(0.13,0)$)      {\tiny #2};
			\node at ($(path picture bounding box.north)+(0,-0.13)$)        {\tiny #3};
			\node at ($(path picture bounding box.east)+(-0.13,0)$)     {\tiny #4};
		}
	}
}
\begin{document}
	
	%\begin{figure}
	%\centering
	\tikzstyle{block} = [draw, fill=blue!20, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{controller} = [draw, fill=red!20, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{sum} = [draw, fill=blue!20, circle, node distance=1cm]
	\tikzstyle{input} = [coordinate]
	\tikzstyle{output} = [coordinate]
	\tikzstyle{sampleSP} = [coordinate]
	\tikzstyle{sampleEP} = [coordinate]
	\tikzstyle{otherPoint} = [coordinate]
	\begin{tikzpicture}[auto, >=latex']
	% Nodes
	\node [input] (input) {};
	%\node [sum, right = 1cm of input] (sum) {};
	\node[draw,circle,add={--}{+}{}{},right of= input](sum){}; 
	%\node [sampleSP, right = 1cm of sum] (sumSP) {};
	%\node [sampleEP, right = 1cm of sumSP] (sumEP) {};
	%\node [sampleEP, above = 1cm of sumEP] (sumEPTOP) {};
	\node [block, right = 0.5cm of sum] (system) {$\cfrac{K(z+1)}{(z-1)(z-0.6065)}$}; % node[label=below:$b_1$,draw]{};
	%\node [below = 0.005 cm of system] (PointHeader) {\scriptsize{$G(s)$}};
	\node [otherPoint,right = 0.5cm of system] (branchPoint) {};
	\node [otherPoint,below = 0.5 cm of system] (belowsystem) {}; %{$\frac{1}{Ts+1}$};
	%\node [block, right = 1cm of system] (system2) {$\frac{1}{Ts+1}$};
	\node [output, right = 1cm of branchPoint] (output) {};
	\node [input, below = 0.5cm of system] (m) {};
	%\node [otherPoint, right = 1.25 of belowsystem] (systemRightDownP) {$H_1(s)$};
	
	% Second Sampler Point
	%\node [sampleSP, below = 0.5cm of systemRightDownP] (sysHSP2) {};
	%\node [sampleEP, left = 1cm of sysHSP2] (sysHEP2) {};
	%\node [sampleEP, above = 1cm of sysHEP2] (sumEPTOP2) {};
	
	% Second block 
	%\node [block, left = 0.75cm of sysHEP2] (systemH2) {$\cfrac{1-e^{-Ts}}{s}$};
	% Arrows
	\draw [draw,->] (input) -- node {$R(z)$} (sum);
	% Arrows for first sampler
	%	\draw [-] (sum) -- node {$E(s)$} (sumSP);
	%	\draw [-,thick] (sumEPTOP) -- node {$\delta_\tau$} (sumSP);
	
	%\draw [->] (sum) -- node {$E(s)$} (system);
	\draw [->] (sum) -- node {} (system);
	%Arrows for second sampler (bottom)
	%	\draw [-]  (sysHSP2)-- node {$M(s)$} (systemH);  
	%\draw [-,thick] (sysHSP2) -- node {$\delta_\tau$} (sumEPTOP2);
	%\draw [->] (sumEP) -- node {$M^\ast(s)$} (systemH);
	% \draw [->] (system) --  (system2);
	\draw [-] (system) --  (branchPoint);
	\draw [->] (branchPoint) -- node (y) {$C(z)$}(output);
	%\draw [-] (y) |- (sysHSP2) {};
	\draw [-] (y) |- (m) {} ;
	%\draw [<-] (systemH2) -- node {$M^\ast(s)$} (sysHEP2);
	%\draw [->] (sysHEP2) -- (systemH2);
	%\draw [->] (systemH2) -| node [near end] {$B(s)$} (sum) ; %{$-$}  node [near end] {} (sum);
	%\node [otherPoint, below = 1.25cm of sum] (Text) {$B(s)$};
	\draw [->] (m) -| node[pos=0.99] {} node [near end] {} (sum); %{$-$}  node [near end] {} (sum);
	\end{tikzpicture}
	%\end{figure}
\end{document}
```
# ElectroMag

![ElectroMag](ElectroMag/BHCurve.png?raw=true "BHCurve")

```tex
\documentclass{standalone}
\usepackage{pgfplots}
\usepgfplotslibrary{fillbetween}

\begin{document}
    \begin{tikzpicture}
        \begin{axis}[very thick,
                     samples = 100,
                     xlabel = H,
                     ylabel = B,
                     xmin = -7,
                     xmax = 7,
                     ymin = -4,
                     ymax = 4,
                     axis x line = middle,
                     axis y line = middle,
                     ticks = none]
            \addplot[dashed] plot (\x, 2.5);
            \addplot[dashed] plot (\x,-2.5);
            \addplot[red, name path=A] plot (\x, {5/(1 + exp(-1.7*\x+1.5))-2.5});
            \addplot[red, name path=B] plot (\x, {5/(1 + exp(-1.7*\x-1.5))-2.5});
            \addplot[red!20] fill between[of=A and B];
        \end{axis}
    \end{tikzpicture}
\end{document}
```
![ElectroMag](ElectroMag/Exampl1Circuit.png?raw=true "Exampl1Circuit")

```tex

\documentclass{standalone}
\usepackage{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}

	\begin{circuitikz}[american voltages,scale =1]
		\draw (0,8) to [voltage source,l_=$\mathscr{F}(\equal NI)$] (0,0) -- (4,0)
		%node[anchor=south] {$v_L$}
		to [R, l_= $R_{a2} \quad Air \ Gap \ 2 \ Reluctance $,color=purple] (4,2)
		to [R, l_= $R_{r} \quad Rotor \ Reluctance $,color=blue] (4,4)
		to [R,i^<=$\phi$, l_= $R_{a1} \quad Air \ Gap \ 1 \ Reluctance $,color=purple] (4,6)
		to [R, l_= $R_{s} \quad Stator \ Reluctance $,color=red] (4,8)
		(4,8) -- (0,8)
		%(2,3) -- (4,3) to [L=$L$, i>^=$i_L(t)$, v=$v_L(t)$] (4,0) -- (0,0)
		(2,4) node[scale=4]{$\textcolor{red}{\circlearrowright}$}
		(2,4) node[scale=2]{$\textcolor{red}{\mathbf{\phi}}$};
		;\end{circuitikz}
\end{document}
```
![ElectroMag](ElectroMag/Exampl2Circuit.png?raw=true "Exampl2Circuit")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
	\begin{circuitikz}
		\draw (0,3) to [V,l_=$\mathscr{F}\equal NI$] (0,0) 
		(0,3) node[anchor=south] {$\textcolor{red}{1}$} to [R,i^>=$\phi_1$, l^=$\mathscr{R}_1$,*-,color=red] (3,3)
			node[anchor=south] {$\textcolor{blue}{2}$}
		to [R, l_= $\mathscr{R}_2$, *-, i>^=$\phi_2$,color=blue] (3,0) 
			node[anchor=north] {$\textcolor{purple}{3}$}
		%(3,3) -- (6,3) to [L=$L$, i>^=$i_L(t)$, v=$v_L(t)$] (6,0) -- (0,0)
		(3,3) -- (6,3) to [R=$L$,l_=$\mathscr{R}_3$, i>^=$\phi_3$, *- ,color=purple] (6,0) -- (0,0)
		(6,0) -- (0,0)
		;\end{circuitikz}
	\label{fig:q1fig}
\end{document}
```
![ElectroMag](ElectroMag/phasor.png?raw=true "phasor")

```tex
\documentclass{standalone}
\usepackage{tikz} 
\usepackage{siunitx} 

\begin{document}        
\begin{tikzpicture}[>=latex]
%\draw[style=help lines] (0,0) (3,2);

%\coordinate (vec1) at (300:1.5); 
%\coordinate (vec2) at (30:2.5);
%\coordinate (vec3) at (0:2.5);
%\coordinate (vec4) at (90:2);
%\coordinate (vec5) at (270:2);
%\coordinate (vec6) at (180:2);

\coordinate (vec1) at (0:2.5); 
\coordinate (vec1mid) at (0:2);
\coordinate (vec2) at (270:2.5);
\coordinate (vec3) at (315:3);
\draw[->,thick,black] (0,0) -- (vec1) node[right] {$\bar{V}_2 \angle0^\circ$};
\draw[->,thick,black] (0,0) -- (vec1mid) node[midway,above] {$I_R = 2.8  \angle0^\circ A$};
\draw[->,thick,black] (0,0) -- (vec2) node[below right] {$I_L=2.8  \angle-90^\circ$};
\draw[->,thick,black] (0,0) -- (vec3) node[midway, below, sloped] {$I_{Load} = 4 A$};
%\draw[->,thick,black] (0,0) -- (vec3) node [below] {$Re$};
%\draw[->,thick,black] (0,0) -- (vec4) node [left] {$Im$};
%\draw[->,thick,black] (0,0) -- (vec5);
%\draw[->,thick,black] (0,0) -- (vec6);

%\draw [black, thick ] (1.0,0) arc (0:30:1cm)    node [midway, right] {$\theta=45^\circ$};    
\draw [black, thick] (0.5,0) arc (0:-60:0.38cm) node [midway, right] {$\theta=45^\circ$};  

\end{tikzpicture}
\end{document}
```
![ElectroMag](ElectroMag/PrimarySide.png?raw=true "PrimarySide")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usetikzlibrary{calc,arrows}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
	\begin{circuitikz}
		\draw (0,6) to [open,l=$v_1$,o-o] (0,0) 
		(0,6) to  [R,i>=$i_1$, l^= $R_{1}$, color=red] (2,6) 
		(2,6) to  [L,i>=$i_1$,l^= $L_{l1}$, color=blue] (4,6) 
		(4,6) -- (6,6)
		(6,6) to [short,i=$i^\prime_e$,*-*] (6,4)
		(6,4) -- (5,4)
		(6,4) -- (7,4)
		(5,4) to [R,i^>=$i^\prime_c$, l_= $R^{\prime}_c\equal 124K \Omega$, color=red] (5,0)
		(7,4) to [L,i^<=$i^\prime_m$, l^= $L^{\prime}_m \equal 5.4 H$, color=blue] (7,0)
		(6,6) to [short,i=$i^\prime_2 \equal i_2 / k$] (10,6)
		(0,0) -- (10,0)
		(11,6) node [yscale =2.857,transformer core](T){}  % reminded by @PaulGessler, thanks.
		(T.A1) node[above] {$N_1$}
		(T.A2) node[below] {primary}
		(T.B1) node[above] {$N_2$} 
		(T.B2) node[below] {secondary}
		(T.base) node{K}

		(T.B1) -- (12,6)
		(14,6) to [L,i^<=$i_2$, l_= $L_{l2}$, color=blue] (12,6)
		(14,6) to [R, l^= $R_{2}$, color=red] (16,6)
		(16,6) to [generic, l_=${Load}$](16,0)
		(T.B2) -- (16,0)
%	    (4,0) -- (0,0) 
%	     (4,4) to [R,i^>=$\phi_2$, l^= $\mathscr{R}_{2}$,v_>=$\mathscr{F}_2$, color=blue] (4,0)
%		(4,4) to [R,l^= $\mathscr{R}_{3}$,v_>=$\mathscr{F}_3$, color=red] (8,4)
%		(8,4) to [R,i^>=$\phi_3$, l^= $\mathscr{R}_{g}$,v_>=$\mathscr{F}_g$, color=cyan] (8,0)
%		(8,0) to [R, l^= $\mathscr{R}_{4}$,v_>=$\mathscr{F}_4$, color=green] (4,0);
%		\draw[thin, <-, >=triangle 45] (6,2) node{$\phi_3$}   ++(-90:1) arc (-90:100:1);
%		\draw[thin, <-, >=triangle 45] (2,2) node{$\phi_2$}   ++(-90:1) arc (-90:100:1);
%		\node (phi) at (4.25,0.5) {$\phi_2$};
%		\draw[-stealth]  (4.25,2.5) to [bend left=90] (phi);  
;
\coordinate (V1up) at (0.5,6);
\coordinate (V1mid1) at (0.5,3.25);
\coordinate (V1mid2) at (0.5,2.75);
\coordinate (V1down) at (0.5,0);
\node (e) at (2.5,3) {$e_{11}$};
\node (eend) at (9.5,3) {$e_{1}$};
\node (e2) at (12,3) {$e_{2}$};
\node (e3) at (14,3) {$e_{22}$};
\draw[->,black,very thick] (e) -- ($(e)!.85!(2.5,6)$); % 1 cm before end terminal
\draw[->,black,very thick] (e) -- ($(e)!.85!(2.5,0)$); % 1 cm before start terminal
\draw[->,black,very thick] (eend) -- ($(eend)!.85!(9.5,6)$); % 1 cm before end terminal
\draw[->,black,very thick] (eend) -- ($(eend)!.85!(9.5,0)$); % 1 cm before start terminal
\draw[->,black,very thick] (e2) -- ($(e2)!.85!(12,6)$); % 1 cm before end terminal
\draw[->,black,very thick] (e2) -- ($(e2)!.85!(12,0)$); % 1 cm before start terminal
\draw[->,black,very thick] (e3) -- ($(e3)!.85!(14,6)$); % 1 cm before end terminal
\draw[->,black,very thick] (e3) -- ($(e3)!.85!(14,0)$); % 1 cm before start terminal
\draw[->,black,very thick] (V1mid2) -- ($(V1mid2)!.85!(V1down)$); % 1 cm before end terminal
\draw[->,black,very thick] (V1mid1) -- ($(V1mid1)!.85!(V1up)$); % 1 cm before start terminal
	\end{circuitikz}
	\label{fig:q1fig}
\end{document}
```
![ElectroMag](ElectroMag/Q1Circuit.png?raw=true "Q1Circuit")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}

\newcommand{\equal}{=}
\begin{document}
	\begin{circuitikz}
		\draw (0,3) to [V,l_=$\mathscr{F}\equal NI$] (0,0) 	% "Voltage source for magentic circuit"
		(0,3) to [R,l^=$\mathscr{R}_{1,thick}$, v_>=$\mathscr{F}_1$, color=red] (0,6)	%Reluctance thick side
		(0,6) to [R, l^=$\mathscr{R}_{2,thin}$,v_>=$\mathscr{F}_2$, color=blue] (3,6)   %Reluctance thin side
		(3,6) -- (3,3)		% Connection R2, R3
	    (3,3) to [R, l^=$\mathscr{R}_{3,thick}$,v_>=$\mathscr{F}_3$, color=red] (3,0)   %Reluctance thick side
	     (3,0) to [R, l^= $\mathscr{R}_{4,thin}$,v_>=$\mathscr{F}_4$, color=blue] (0,0); %Reluctance thin side
	     
	    \draw[thin, <-, >=triangle 45] (1.5,3) node[scale=2]{$\phi$}  ++(-90:1) arc (-90:100:1);
		\end{circuitikz}
	\label{fig:q1fig}
\end{document}
```
![ElectroMag](ElectroMag/Q1Circuit2.png?raw=true "Q1Circuit2")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\usetikzlibrary{bending}
\newcommand{\equal}{=}
\begin{document}
	\begin{circuitikz}
		\draw (0,3) to [V,l_=$\mathscr{F}\equal NI$] (0,0) 
		(0,3) -- (3,3) 
	    (3,0) -- (0,0) 
	     (3,3) to [R, l^= $\mathscr{R}_{eq}$,v_>=$\mathscr{F}$, color=blue] (3,0);
	     
%	     \draw[thin, <-, >=triangle 45] (1.5,1.5) node[scale=2]{$\phi$}   ++(-90:0.5) arc (-90:100:0.5);
		\node (phi) at (1.5,0.5) {$\phi$};
		\draw[-stealth]  (1.5,2.5) to [bend left=90] (phi);     
		\end{circuitikz}
	\label{fig:q1fig}
\end{document}
```
![ElectroMag](ElectroMag/Q2Circuit.png?raw=true "Q2Circuit")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
		\begin{circuitikz}
			\draw (3,4) to [V,l_=$\mathscr{F}\equal NI$] (3,2) 
			(3,2) to [R,l^=$\mathscr{R}_{g1}$, v_>=$\mathscr{F}_1$, color=green] (3,0)
			(3,2) -- (3,0)
			(3,0) -- (0,0)
			(0,4) to [R,l^=$\mathscr{R}_{g2}$, v_>=$\mathscr{F}_2$, color=red] (0,0)
			(6,4) to [R, l^=$\mathscr{R}_{g3}$,v_>=$\mathscr{F}_3$, color=blue] (6,0) 
			(6,0) -- (3,0)
			(0,4) -- (6,4);
			%	     \draw[thin, <-, >=triangle 45] (1.5,1.5) node[scale=2]{$\phi$}   ++(-90:0.5) arc (-90:100:0.5);
			\node (phi) at (1.25,0.5) {$\phi_1$};
			\draw[-stealth]  (1.25,2.5) to [bend left=90] (phi);  
			
			\node (phi) at (4.25,0.5) {$\phi_2$};
			\draw[-stealth]  (4.25,2.5) to [bend left=90] (phi);  
			\end{circuitikz}
%	\begin{circuitikz}
%		\draw (0,3) to [V,l_=$\mathscr{F}\equal NI$] (0,0) 
%		(0,3) to [R,l^=$\mathscr{R}_{1,thick}$, v_>=$\mathscr{F}_1$, color=red] (0,6)
%		(0,6) to [R, l^=$\mathscr{R}_{2,thin}$,v_>=$\mathscr{F}_2$, color=blue] (3,6) 
%		(3,6) -- (3,3)
%	    (3,3) to [R, l^=$\mathscr{R}_{3,thick}$,v_>=$\mathscr{F}_3$, color=red] (3,0) 
%	     (3,0) to [R, l^= $\mathscr{R}_{4,thin}$,v_>=$\mathscr{F}_4$, color=blue] (0,0)
%	     
%	     (1.5,3) node[scale=4]{${\circlearrowright}$}
%	     (1.5,3) node[scale=2]{${\mathbf{\phi}}$};
%		;\end{circuitikz}
%	\label{fig:q1fig}
\end{document}
```
![ElectroMag](ElectroMag/Q3Circuit.png?raw=true "Q3Circuit")

```tex
%corresponds to question 4, ELEC 370 assignment 1.
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
	
			\begin{circuitikz}
				\draw (0,2) to [V,l_=$\mathscr{F}\equal NI$] (1.5,2) 
				(0,0) --(0,4)
				(0,0) -- (4,0)
				(0,4) -- (4,4)
				(4,0) to [R,l^=$\mathscr{R}_{s}$, v_>=$\mathscr{F}_1$, color=green] (4,2)
				(4,4) to [R,l_=$\mathscr{R}_{s}$, v^>=$\mathscr{F}_2$, color=blue] (4,2)
				(1.5,2)  to [R,l_=$\mathscr{R}_{g}$, v^<=$\mathscr{F}_2$,i_<=$\phi$, color=red] (4,2);
				
				\node (phi) at (2.5,3) {$\phi_1$};
				\draw[-stealth]  (1,2.5) to [bend left=90] (phi);  
				
				\node (phi) at (2.5,0.5) {$\phi_2$};
				\draw[-stealth]  (1,0.25) to [bend left=90] (phi); 
			\end{circuitikz}
\end{document}
```
![ElectroMag](ElectroMag/Q3Circuit2.png?raw=true "Q3Circuit2")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
	
			\begin{circuitikz}
				\draw (0,2) to [V,l_=$\mathscr{F}\equal NI$] (0,0) 
				(0,0) to [R,l^=$\mathscr{R}_{g}$, v_<=$\mathscr{F}_1$, color=green] (4,0)
				(0,2) to [R,l_=$0.5\mathscr{R}_{s}$, v^>=$\mathscr{F}_2$, color=blue] (4,2)
				(4,2) -- (4,0);
			\node (phi) at (3.0,0.25) {$\phi$};
			\draw[-stealth]  (3.25,1.75) to [bend left=90] (phi); 
			\end{circuitikz}
\end{document}
```
![ElectroMag](ElectroMag/Q4Circuit.png?raw=true "Q4Circuit")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
	
			\begin{circuitikz}
				\draw (4,0) to [V,l_=$\mathscr{F}\equal NI$, -*] (6,0) 
				(2,0) -- (2,2)
				(2,2) to [R,l^=$\mathscr{R}_{l}$,i^>=$\phi_l$, v_>=$\mathscr{F}_1$, color=purple] (6,2)
				(6,2) -- (6,0)
				(2,0) to [R,l^=$\mathscr{R}_{l2}$,i^<=$\phi_t$, v_<=$\mathscr{F}_{l2}$, *-, color=blue] (4,0)
				(2,0) -- (0,0)
				(0,0) to [R,l^=$\mathscr{R}_{l1}$, v_>=$\mathscr{F}_{l1}$, color=red]  (0,4)
				(6,0) -- (8,0)
				(8,4) to [R,l^=$\mathscr{R}_{l1}$, v_>=$\mathscr{F}_{l1}$, color=red]  (8,0)
				(0,4) -- (3,4)
				(3,4) to [R,l^=$\mathscr{R}_{g}$,i^>=$\phi_g$, v_>=$\mathscr{F}_{g}$, color=green] (5,4) 
				(5,4) -- (8,4);
%				(0,0) to [R,l^=$\mathscr{R}_{g}$, v_<=$\mathscr{F}_1$, color=green] (4,0)
%				(0,2) to [R,l_=$0.5\mathscr{R}_{s}$, v^>=$\mathscr{F}_2$, color=blue] (4,2)
%				(4,2) -- (4,0)
			\node (phi) at (7.0,1.25) {$\phi_{Meme}$};
			\draw[-stealth]  (1,1.25) to [bend left=90] (phi);
			\end{circuitikz}
\end{document}
```
![ElectroMag](ElectroMag/Q5Circuit.png?raw=true "Q5Circuit")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
	\begin{circuitikz}
		\draw (0,3) to [V,l_=$\mathscr{F}\equal NI$] (0,0) 
		(0,3) to  [R, l^= $\mathscr{R}_{i}$,v_>=$\mathscr{F}_i$, color=purple] (3,3) 
	    (3,0) -- (0,0) 
	     (3,3) to [R, l^= $\mathscr{R}_{a}$,v_>=$\mathscr{F}_a$, color=blue] (3,0);
	     
	      \draw[thin, <-, >=triangle 45] (1.5,1.5) node[scale=2]{$\phi$}   ++(-90:0.5) arc (-90:100:0.5);
      \end{circuitikz}
	\label{fig:q1fig}
\end{document}
```
![ElectroMag](ElectroMag/Q6Circuit.png?raw=true "Q6Circuit")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
	\begin{circuitikz}
		\draw (0,4) to [V,l_=$\mathscr{F}\equal NI$] (0,0) 
		(0,4) to  [R,i>=$\phi_1$, l^= $\mathscr{R}_{1}$,v_>=$\mathscr{F}_1$, color=purple] (4,4) 
	    (4,0) -- (0,0) 
	     (4,4) to [R,i^>=$\phi_2$, l^= $\mathscr{R}_{2}$,v_>=$\mathscr{F}_2$, color=blue] (4,0)
		(4,4) to [R,l^= $\mathscr{R}_{3}$,v_>=$\mathscr{F}_3$, color=red] (8,4)
		(8,4) to [R,i^>=$\phi_3$, l^= $\mathscr{R}_{g}$,v_>=$\mathscr{F}_g$, color=cyan] (8,0)
		(8,0) to [R, l^= $\mathscr{R}_{4}$,v_>=$\mathscr{F}_4$, color=green] (4,0);
		\draw[thin, <-, >=triangle 45] (6,2) node{$\phi_3$}   ++(-90:1) arc (-90:100:1);
		\draw[thin, <-, >=triangle 45] (2,2) node{$\phi_2$}   ++(-90:1) arc (-90:100:1);
%		\node (phi) at (4.25,0.5) {$\phi_2$};
%		\draw[-stealth]  (4.25,2.5) to [bend left=90] (phi);  
	\end{circuitikz}
	\label{fig:q1fig}
\end{document}
```
![ElectroMag](ElectroMag/Q7Circuit.png?raw=true "Q7Circuit")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
	\begin{circuitikz}
		\draw (0,6) to [R,i^>=$\phi_2$, l^= $\mathscr{R}_{g1}$,v_>=$\mathscr{F}_{g1}$, color=blue] (0,0)
		(0,6) to  [R,i>=$\phi_1$, l^= $\mathscr{R}_{ab}$,v_>=$\mathscr{F}_1$, color=purple] (4,6) 
	    (0,0) to [R,i^>=$\phi_2$, l^= $\mathscr{R}_{cd}$,v_>=$\mathscr{F}_{cd}$, color=gray] (4,0)
	    (4,2) to [I,l_=$N_1i$] (4,4)
	    (4,2) to [I,l_=$N_2i$] (4,0)
	    (4,4)  to  [R,i>=$\phi_1$, l^= $\mathscr{R}_{ad}$,v_>=$\mathscr{F}_{ad}$, color=orange] (4,6)
		(4,6) to [R,l^= $\mathscr{R}_{3}$,v_>=$\mathscr{F}_3$, color=red] (8,6)
		(8,6) to [R,i^>=$\phi_3$, l^= $\mathscr{R}_{g2}$,v_>=$\mathscr{F}_{g2}$, color=cyan] (8,0)
		(8,0) to [R, l^= $\mathscr{R}_{dc}$,v_>=$\mathscr{F}_{dc}$, color=green] (4,0);
	\end{circuitikz}
	\label{fig:q1fig}
\end{document}
```
![ElectroMag](ElectroMag/Q7Circuit2.png?raw=true "Q7Circuit2")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
	\begin{circuitikz}
		\draw (0,0) to [R,i^<=$\phi_1$, l^= $\mathscr{R}_{g1}$,v_<=$\mathscr{F}_{g1}$, color=blue] (0,6)
		(0,6) -- (4,6)
		(0,0) -- (4,0)
		(4,0) to [I,i=$\phi$,l_=$(N_1-N_2)i$] (4,4)
		(4,4) -- (4,6) 
		(8,0) -- (4,0)
		(4,6) to [R,l^= $\mathscr{R}_{3}$,v_>=$\mathscr{F}_3$, color=red] (8,6)
		(8,0) to [R,i^<=$\phi_2$, l^= $\mathscr{R}_{g2}$,v_<=$\mathscr{F}_{g2}$, color=cyan] (8,6)

		;\end{circuitikz}
	\label{fig:q1fig}
\end{document}
```
![ElectroMag](ElectroMag/Q8Circuit.png?raw=true "Q8Circuit")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
	\begin{circuitikz}
		\draw (6,0) to [V,i^>=$\phi_T$, l^= $\mathscr{F}$,v_>=$NI$, color=blue] (0,0)
		(0,0) -- (0,4)
		(0,4) -- (1,4)
		(1,4) -- (1,2)
		(1,4) -- (1,6)
		(1,6) to [R,i>=$\phi_1$, l^= $\mathscr{R}_{2}$,v_>=$\mathscr{F}_2$, color=purple] (3,6)
		(3,6) to [R, l^= $\mathscr{R}_{3}$,v_>=$\mathscr{F}_3$, color=purple] (5,6)
		(5,6) -- (5,4)
		(1,2) to [R,i>=$\phi_1$, l^= $\mathscr{R}_{1}$,v_>=$\mathscr{F}_1$, color=red] (4,2)
		(4,2) -- (5,2)
		(5,2) -- (5,4)
		(5,4) -- (6,4)
		(6,4) -- (6,0) 
		;\end{circuitikz}
	\label{fig:q1fig}
\end{document}
```
![ElectroMag](ElectroMag/Transformer3Windings.png?raw=true "Transformer3Windings")

```tex
\documentclass[tikz,border=3mm]{standalone}

\usetikzlibrary{quotes,arrows.meta}

\begin{document}

\tikzset{
    terminal_a/.pic = {%
        \coordinate (-in) at (-3mm,0);
        \coordinate (-out) at (-3mm,-4.5mm);

        \path[fill] (-in) circle (2pt);
        \draw[thick] (-in)--(0,0)--++(0:1cm) arc[start angle=90, delta angle=-180, radius=.75mm]; 
        \draw[thick] (0,-1.5mm) arc[start angle=90, delta angle=180, radius=.75mm]--++(0:1cm) arc[start angle=90, delta angle=-180, radius=.75mm]; 
        \fill (-out) circle (2pt);
        \draw[thick] (-out) -- ++(0:3mm);
        },
    terminal_b/.pic = {%
        \coordinate (-in) at (-3mm,0);
        \coordinate (-out) at (-3mm,-7.5mm);

        \path[fill] (-in) circle (2pt);
        \draw[thick] (-in)--(0,0)--++(0:1cm) arc[start angle=90, delta angle=-180, radius=.75mm]; 
        \draw[thick] (0,-1.5mm) arc[start angle=90, delta angle=180, radius=.75mm]--++(0:1cm) arc[start angle=90, delta angle=-180, radius=.75mm]; 
        \draw[thick] (0,-4.5mm) arc[start angle=90, delta angle=180, radius=.75mm]--++(0:1cm) arc[start angle=90, delta angle=-180, radius=.75mm]; 
        \fill (-out) circle (2pt);
        \draw[thick] (-out) -- ++(0:3mm);
        },
    field/.pic = {
        \draw[thick,-Stealth] (0,0) -- (90:7mm) node[above] {\tikzpictext};
        }
}

\begin{tikzpicture}
\draw (0,0) rectangle (7,5);
\draw (1,1) rectangle (3,4);
\draw (4,1) rectangle (6,4);

\foreach \i/\j in {0/A,3/B,6/C}{
    \pic (upper-\j) at (\i,3.8) {terminal_a};
    \pic (lower-\j) at (\i,2) {terminal_b};
    \pic["$\Psi_\j$"] at ([xshift=5mm]\i,2.2) {field};
    }

\node[left] at (upper-A-in) {A};
\draw[red] (upper-A-out) to [bend right] (lower-A-in);

\end{tikzpicture}
\end{document}
```
