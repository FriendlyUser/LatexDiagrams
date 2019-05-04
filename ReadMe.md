## Latex Diagrams
This repo contains all the diagrams I have generated for my academic career at the University Of Victoria.

# ControlSystems/CSI

![ControlSystems/CSI](ControlSystems/CSI/BlockDiagramex2.png?raw=true "BlockDiagramex2")

```tex
\documentclass{standalone}

\usepackage{blox}
\usepackage{tikz}
\usetikzlibrary{positioning}

\begin{document}
\begin{tikzpicture}
%\bXLineStyle{red, dotted}
\bXLineStyle{very thick}
\bXInput{A}
\bXComp{B}{A}
\bXLink[R]{A}{B}
\bXCompa{C}{B}
\bXLink{B}{C}
\bXSumb{D}{C}
\bXLink{C}{D}
\bXBloc[2]{E}{$G_1$}{D}
\bXLink{D}{E}
\bXBloc[2]{F}{$G_2$}{E}
\bXLink{E}{F}

\bXBranchx[5]{F}{FX1}

\bXBranchy[5]{FX1}{FDown1}
\draw[-,very thick] (F) -- (FX1.center);
\draw[-,very thick] (FX1.center) -- (FDown1.center);
\bXBranchx[-5.5]{FDown1}{FRight1}
\draw[->,very thick] (FDown1.center) -- (FRight1.center);
\bXBloc[-3.5]{H1}{$H_1$}{FRight1}
\bXBranchy[5]{D}{DDown1}
\draw[->,very thick] (DDown1.center) -- (D);
\draw[-,very thick] (H1) -- (DDown1.center);

\bXBloc[2]{G}{$G_3$}{FX1}
%\draw[-,very thick]  (F)  -- (FX1);
\draw[->,very thick] (F) -- (G);

\bXBranchx[3]{G}{GX1}
\bXBranchx[3]{GX1}{GX2}
\draw[-,very thick] (G) -- (GX2);
\bXBranchx[3]{GX2}{GX3}
\bXBranchy[-5]{GX2}{GUp1}

\bXBranchx[1.5]{GX2}{GX4}
\bXBranchy[7.5]{GX4}{GDown1}
%\draw[-,very thick] (G) -- (GX1.center);
%\draw[-,very thick] (G) -- (GX1.center);
%\draw[-,very thick] (GX1.center) -- (GUp1.center);
%\bXLinkxy{GX1}{GUp1}
\draw[-,very thick] (GX1.center) -- (GX2.center);
\draw[-,very thick] (GX2.center) -- (GUp1.center);
\draw[->,very thick] (GX2.center) -- (GX3.center);
\node[right = 0.05cm of GX3] (end) {$C$};

\draw[-,very thick] (GX4.center) -- (GDown1.center);

\bXBranchy[7.5]{B}{BDown1}
\bXLink{BDown1.center}{B}
\draw[-,very thick] (GDown1.center) -- (BDown1.center);


%% Top Part

\bXBranchx[-20]{GUp1}{GLUp1}
\bXBloc[-0]{BlockHG}{$\frac{H_2}{G_1}$}{GLUp1}
\draw[->,very thick] (GUp1.center) -- (BlockHG);
\bXLinkxy{BlockHG}{C}
\end{tikzpicture}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/conSys.png?raw=true "conSys")

```tex
\documentclass{standalone}

\usepackage{tikz}
\usetikzlibrary{shapes,arrows}
\begin{document}


\tikzstyle{block} = [draw, fill=blue!20, rectangle, 
    minimum height=3em, minimum width=6em]
\tikzstyle{sum} = [draw, fill=blue!20, circle, node distance=1cm]
\tikzstyle{input} = [coordinate]
\tikzstyle{output} = [coordinate]
\tikzstyle{pinstyle} = [pin edge={to-,thin,black}]

% The block diagram code is probably more verbose than necessary
\begin{tikzpicture}[auto, node distance=2cm,>=latex']
    % We start by placing the blocks
    \node [input, name=input] {};
    \node [sum, right of=input] (sum) {};
    \node [block, right of=sum] (controller) {Controller};
    \node [block, right of=controller, pin={[pinstyle]above:Disturbances},
            node distance=3cm] (system) {System};
    % We draw an edge between the controller and system block to 
    % calculate the coordinate u. We need it to place the measurement block. 
    \draw [->] (controller) -- node[name=u] {$u$} (system);
    \node [output, right of=system] (output) {};
    \node [block, below of=u] (measurements) {Measurements};

    % Once the nodes are placed, connecting them is easy. 
    \draw [draw,->] (input) -- node {$r$} (sum);
    \draw [->] (sum) -- node {$e$} (controller);
    \draw [->] (system) -- node [name=y] {$y$}(output);
    \draw [->] (y) |- (measurements);
    \draw [->] (measurements) -| node[pos=0.99] {$-$} 
        node [near end] {$y_m$} (sum);
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/ex1.png?raw=true "ex1")

```tex
\documentclass{standalone}
\usepackage{tikz}
\usetikzlibrary{shapes,arrows,positioning,calc}

\begin{document}
	
	\tikzset{
		block/.style = {draw, fill=white, rectangle, minimum height=3em, minimum width=3em},
		tmp/.style  = {coordinate}, 
		sum/.style= {draw, fill=white, circle, node distance=1cm},
		input/.style = {coordinate},
		output/.style= {coordinate},
		pinstyle/.style = {pin edge={to-,thin,black}
		}
	}
	
	
	
	%\begin{figure}[!htb]
	%\centering
	\begin{tikzpicture}[auto, node distance=2cm,>=latex']
	\node [input, name=rinput] (rinput) {};
	\node [sum, right of=rinput] (sum1) {};
	\node [block, right of=sum1] (controller) {$k_{p\beta}$};
	\node [block, above of=controller,node distance=1.3cm] (up){$\frac{k_{i\beta}}{s}$};
	\node [block, below of=controller,node distance=1.3cm] (rate) {$sk_{d\beta}$};
	\node [sum, right of=controller,node distance=2cm] (sum2) {};
	\node [block, above = 2cm of sum2](extra){$\frac{1}{\alpha_{\beta2}}$};  %
	\node [block, right of=sum2,node distance=2cm] (system) 
	{$\frac{a_{\beta 2}}{s+a_{\beta 1}}$};
	\node [output, right of=system, node distance=2cm] (output) {};
	\node [tmp, below of=controller] (tmp1){$H(s)$};
	\draw [->] (rinput) -- node{$R(s)$} (sum1);
	\draw [->] (sum1) --node[name=z,anchor=north]{$E(s)$} (controller);
	\draw [->] (controller) -- (sum2);
	\draw [->] (sum2) -- node{$U(s)$} (system);
	\draw [->] (system) -- node [name=y] {$Y(s)$}(output);
	\draw [->] (z) |- (rate);
	\draw [->] (rate) -| (sum2);
	\draw [->] (z) |- (up);
	\draw [->] (up) -| (sum2);
	\draw [->] (y) |- (tmp1)-| node[pos=0.99] {$-$} (sum1);
	\draw [->] (extra)--(sum2);
	\draw [->] ($(0,1.5cm)+(extra)$)node[above]{$d_{\beta 2}$} -- (extra);
	\end{tikzpicture}
	%\caption{A PID Control System} \label{fig6_10}
	%\end{figure}
	
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Mason.png?raw=true "Mason")

```tex
\documentclass{article}
\usepackage{tikz}
\usetikzlibrary{decorations.markings}
\newif\iflabrev
\begin{document}
\begin{tikzpicture}
[
label revd/.is if=labrev,
%label revd/.default=true,
amark/.style={
            decoration={             
                        markings,   
                        mark=at position {0.5} with { 
                                    \arrow{stealth},
                                    \iflabrev \node[above] {#1};\else \node[below] {#1};\fi
                        }
            },
            postaction={decorate}
},
terminal/.style 2 args={draw,circle,inner sep=2pt,label={#1:#2}},
]

%Place the nodes
\node[terminal={below}{$f(t)$}] (a) at (0,0) {};
\node[terminal={below left}{$y_1$}] (b) at (3cm,0) {};
\node[terminal={below left}{$\ddot{y}_2$}] (c) at (6cm,0) {};
\node[terminal={[xshift=-4mm]below right}{$\dot{y}_2=x_2$}] (d) at (9cm,0) {};
\node[terminal={below right}{$y_2=x_1$}] (e) at (12cm,0) {};
%Draw the connections
\draw[amark=$1/K$] (a) to (b);
\draw[amark=$K/M$] (b) to (c);
\draw[amark=$s^{-1}$] (c) to (d);
\draw[amark=$s^{-1}$] (d) to (e);
\draw[amark=$-B/M$] (d) to[bend left=45] (c);
\draw[amark=$1$,label revd] (e) to[bend left=50] (b);
\draw[amark=$-K/M$,label revd] (e) to[bend right=50] (c);
\end{tikzpicture}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/pf.png?raw=true "pf")

```tex
\documentclass[11pt]{article}
\pagestyle{empty}
\begin{document}

\begin{center}

\large{\bf MATH0003 Integration \& Differential Equations}
\normalsize

\bigskip

{\bf Partial Fractions} (Anton section 9.5)

\end{center}

\medskip
\noindent
{\bf Definition:} a {\em rational function} 
is a function of the form $P(x)/Q(x)$, 
where $P$ and $Q$ are polynomials.  
A {\em proper} rational function is a rational function 
with the degree of $P$ less than the degree of $Q$.  

\medskip
\noindent
Proper rational functions are usually integrated 
by splitting them up into {\em partial fractions}.  

\medskip
\noindent
{\bf Theorem (partial fractions):} every proper rational function 
may be expressed in the form
\[
\frac{P(x)}{Q(x)} = F_1(x) + F_2(x) + \cdots + F_n(x),
\]
where the $F_i(x)$ are rational functions of the form 
\[
\frac{A}{(ax+b)^k} \;\; {\rm or} \;\; \frac{Ax+B}{(ax^2+bx+c)^k}, 
\]
in which the denominators are factors of $Q$.  
The sum is called the partial fraction decomposition of $P(x)/Q(x)$, 
and the $F_i(x)$ are called partial fractions.  

\medskip
\noindent
Q1. How do we find the {\em form} of the partial fraction decomposition?  

\noindent
Q2. How do we determine the coefficients?  

\medskip
\noindent
{\bf Linear Factor Rule.}  
For each factor of $Q$ of the form $(ax+b)^m$, 
the partial fraction decomposition contains 
the following sum of $m$ partial fractions:  
\[
\frac{A_1}{ax+b} + \frac{A_2}{(ax+b)^2} + \cdots + \frac{A_m}{(ax+b)^m},
\]
where the $A_i$ are constants to be determined.  

\medskip
\noindent
{\bf Quadratic Factor Rule.}  
For each factor of $Q$ of the form $(ax^2+bx+c)^m$, 
where $ax^2+bx+c$ is an irreducible quadratic, 
the partial fraction decomposition contains 
the following sum of $m$ partial fractions:  
\[
\frac{A_1x+B_1}{ax^2+bx+c} + \frac{A_2x+B_2}{(ax^2+bx+c)^2} + \cdots 
  + \frac{A_mx+B_m}{(ax^2+bx+c)^m},
\]
where the $A_i$ and $B_i$ are constants to be determined.  
 
\end{document}

```
![ControlSystems/CSI](ControlSystems/CSI/polesZeroes.png?raw=true "polesZeroes")

```tex
\documentclass{standalone}
\usepackage{tikz}
\usetikzlibrary{shapes.misc}
\begin{document}
\begin{tikzpicture}

% Axes:
\draw [-latex] (-5,0) -- (2.5,0) node [above left]  {$\sigma$};
\draw [-latex] (0,-1) -- (0,4) node [below right] {$j\omega_d$};
\node[cross out,draw=black] at (0,0) {};
%\draw[dashed] (0,0) -- node[pos=0.8, above right] {$\omega_p$}(145:6) node[solid, cross out,draw=black] {};
%\draw[red, -stealth] (0,2) arc (90:145:2);

%\draw[dashed] (0,0) -- node[pos=0.8, above right] {$\omega_z$}(125:3.5) node[solid, fill=white, circle,draw=black] {};
%\draw[dashed] (0,0) -- node[pos=0.8, above right] {$\omega_z$}(125:3.5) node[solid, cross out,draw=black] {};
\draw[dashed] (0,0) -- (125:3.5) node[solid, cross out,draw=black] {};
\draw[black, -stealth] (1.75,0) node[pos=0.1,above right] {$\theta=120^o$} arc (0:125:1.75);

%\draw[dashed]  (-5,0) node[below left] {$-\xi_p\omega_p$} --  (-5,-3) node[solid, cross out,draw=black] {};
%\draw[dashed]  (-2,0) node[below left] {$-\xi_z\omega_z$} --  (-2,-3) node[solid, fill=white, circle,draw=black] {};
%\draw[dashed]  (-2,0) node[below left] {$-\xi$} -- (-2,2.85);
%\draw[dashed]  (0,2.85) node[below left] {$\omega_n$} -- (-2,2.85);
\draw[dashed]  (-2,0) node[below left] {$-2$} -- (-2,2.867);
\draw[dashed]  (0,2.867) node[below left] {$j2\sqrt{(3)}$} -- (-2,2.867);
\draw[dashed]  (125:3.5) -- (-4,0) node[solid, cross out,draw=black] {};
\draw (-4,0) node [below left] {-4};
\draw[black, -stealth] (-2,2)  arc (0:-180:0.3);
\draw (-3,2.25)node[] {$\theta=30^o$};
\end{tikzpicture}


\end{document}

```
![ControlSystems/CSI](ControlSystems/CSI/Q10BlockDiagram.png?raw=true "Q10BlockDiagram")

```tex
\documentclass{standalone}
\usepackage{amsmath}  % For math
\usepackage{amssymb}  % For more math

\usepackage{blox}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\bXInput{A}
\bXComp{B}{A}
\bXLink[$R(s)$]{A}{B}
\bXBloc[2]{C}{$\displaystyle G(s)$}{B}
\bXLink{B}{C}
\bXOutput[4]{E}{C}
\bXLink[$C(s)$]{C}{E}
\bXReturn{C-E}{B}{}
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q1Diagram67.png?raw=true "Q1Diagram67")

```tex
\documentclass{standalone}
\usepackage{amsmath}  % For math
\usepackage{amssymb}  % For more math

\usepackage{blox}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\bXInput{A}
\bXComp{B}{A}
\bXLink[$R(s)$]{A}{B}
\bXBloc[2]{C}{$K\cfrac{s+1}{s+5}$}{B}
%\bXLink[$V_1$]{B}{C}
\bXLink{B}{C}
\bXBloc[2]{D}{$\cfrac{2}{s^2(s+2)}$}{C}
\bXLink{C}{D}
\bXOutput[4]{E}{D}
\bXLink[$C(s)$]{D}{E}
\bXReturn{D-E}{B}{}
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q2Circuit.png?raw=true "Q2Circuit")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
		\begin{circuitikz}
		%\draw (0,4) to [open,v^>=$v_1(t)$,o-o]  (0,0) -- Open Short
		\draw (0,3) to [open,l=$e_i$,o-o]  (0,0) % input
			(0,3) to  [R, l^= $R_1$,-*] (3,3)	%R1
			(3,3) to  [L, l^= $L$,-*] (3,0)	%C1
			(3,3) to [R, l^= $R_2$,-* ] (6,3)	%R2
			(6,3) to  [C, l^= $C$,-*] (6,0)	%C2
			(8,3) to [open,l_=$e_o$,o-o]  (8,0) 	% output
			(0,0) -- (8,0) % wire in bottom 
			(6,3) -- (8,3) % wire to output	
			;
			
		% Current flows in tikz
		\draw[thin, <-, >=triangle 45] (1.5,1.5) node{$i_1$}   ++(-90:0.75) arc (-90:100:0.75);
		\draw[thin, <-, >=triangle 45] (4.5,1.5) node{$i_2$}   ++(-90:0.75) arc (-90:100:0.75);
%		\node (phi) at (4.25,0.5) {$i_2$};
%		\draw[-stealth]  (4.25,2.5) to [bend left=90] (phi);  
	\end{circuitikz}
%	\begin{circuitikz}
%		%\draw (0,4) to [open,v^>=$v_1(t)$,o-o]  (0,0) -- Open Short
%		\draw (0,4) to [open,l^=$e_1$,o-o]  (0,0) 
%		(0,4) to  [R,i>=$\phi_1$, l^= $\mathscr{R}_{1}$,v_>=$\mathscr{F}_1$, color=purple] (4,4) 
%	    (4,0) -- (0,0) 
%	     (4,4) to [R,i^>=$\phi_2$, l^= $\mathscr{R}_{2}$,v_>=$\mathscr{F}_2$, color=blue] (4,0)
%		(4,4) to [R,l^= $\mathscr{R}_{3}$,v_>=$\mathscr{F}_3$, color=red] (8,4)
%		(8,4) to [R,i^>=$\phi_3$, l^= $\mathscr{R}_{g}$,v_>=$\mathscr{F}_g$, color=cyan] (8,0)
%		(8,0) to [R, l^= $\mathscr{R}_{4}$,v_>=$\mathscr{F}_4$, color=green] (4,0);
%		\draw[thin, <-, >=triangle 45] (6,2) node{$\phi_3$}   ++(-90:1) arc (-90:100:1);
%		\draw[thin, <-, >=triangle 45] (2,2) node{$\phi_2$}   ++(-90:1) arc (-90:100:1);
%%		\node (phi) at (4.25,0.5) {$\phi_2$};
%%		\draw[-stealth]  (4.25,2.5) to [bend left=90] (phi);  
%	\end{circuitikz}
	\label{fig:q1fig}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q2Diagram614.png?raw=true "Q2Diagram614")

```tex
\documentclass{standalone}
\usepackage{amsmath}  % For math
\usepackage{amssymb}  % For more math

\usepackage{blox}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\bXInput{A}
\bXComp{B}{A}
\bXLink[$R(s)$]{A}{B}
\bXBloc[2]{C}{$\cfrac{K}{s(s^2+4s+5)}$}{B}
%\bXLink[$V_1$]{B}{C}
\bXLink{B}{C}
\bXOutput{E}{C}
\bXLink[$C(s)$]{C}{E}
\bXReturn{C-E}{B}{}
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q3Circuit.png?raw=true "Q3Circuit")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
		\begin{circuitikz}
		%\draw (0,4) to [open,v^>=$v_1(t)$,o-o]  (0,0) -- Open Short
		\draw (0,6) to [open,l=$e_i$,o-o]  (0,1) % input
			(0,6) to  [C, l^= $C$,-*] (2,6)	%C
			(2,6) to  [R, l^=$R_1$,-*] (2,1)	%R1
			(2,1) -- (2,0.5) node[ground]{}	%ground
			(5, 5.5) node[op amp,yscale=-1] (opamp) {}
			(2,	6) to [open, -*] (3.5,6) node[above]{$A$}
			(2,6) -- (opamp.+) 
		     (3.5,5) node[left]{$B$} to [short,*-] 	(opamp.-)
		     (opamp.out)  to [short,-*]  (6.5,5.5)
		     to [R, l_=$R_2$,-*] (6.5,3) %R2
		     to [R, l_=$R_3$, -*] (6.5,1)
		     (6.5,3) -- (3.5,3)	% connect B to middle of resistors
		     (3.5,3) -- (3.5,5)	% vertical connection to B
			(6.5,5.5) -- (7.5,5.5)
			(7.5,5.5) to [open,l_=$e_o$,o-o]  (7.5,1) % output
			(0,1) -- (7.5,1) % wire
			;
	\end{circuitikz}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q3Circuit2.png?raw=true "Q3Circuit2")

```tex
\documentclass{standalone}
\usepackage[american]{circuitikz}
\usepackage{graphicx}
\usepackage{mathrsfs} 
\usepackage{latexsym,amssymb,amsmath}
\newcommand{\equal}{=}
\begin{document}
		\begin{circuitikz}
		%\draw (0,4) to [open,v^>=$v_1(t)$,o-o]  (0,0) -- Open Short
		\draw (0,6) to [open,l_=$e_i$,o-o]  (0,1) % input
			(0,6) to  [C, l_= $C$,-*] (2,6)	%C
			(1,6) node[] (Z2) {}	% used for drawing rectangle
			(2,6) to  [R, l_=$R_1$,-*] (2,1)	%R1
			node[] (Z2end) {}	% used for drawing rectangle
			(2,1) -- (2,0.5) node[ground]{}	%ground
			(5, 5.5) node[op amp] (opamp) {}
			(2,	6) to [open, -*] (3.5,6) node[above]{$A$}
			(2,6) -- (opamp.-) 
		     (3.5,5) node[left]{$B$} to [short,*-] 	(opamp.+)
		     (opamp.out)  to [short,-*]  (6.5,5.5)
		     node[] (Z1) {}	% used for drawing rectangle
		     to [R, l^=$R_2$,-*] (6.5,3) %R2
		     to [R, l^=$R_3$, -*] (6.5,1)
		      node[] (Z1end) {} % used for drawing rectangle
		     (6.5,3) -- (3.5,3)	% connect B to middle of resistors
		     (3.5,3) -- (3.5,5)	% vertical connection to B
			(6.5,5.5) -- (7.5,5.5)
			(7.5,5.5) to [open,l^=$e_o$,o-o]  (7.5,1) % output
			(0,1) -- (7.5,1) % wire
			;
			\draw[thick,dotted]     ($(Z1.north west)+(-0.5,0.15)$) rectangle ($(Z1end.south east)+(0.5,-0.15)$);
			\draw (Z1.north) +(0,0.5) node {$Z_1$};
			\draw[thick,dotted]     ($(Z2.north west)+(-0.5,0.25)$) rectangle ($(Z2end.south east)+(0.5,-0.15)$);
			\draw (Z2.north) +(0,0.5) node {$Z_2$};
	\end{circuitikz}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q3Diagram616.png?raw=true "Q3Diagram616")

```tex
\documentclass{standalone}
\usepackage{amsmath}  % For math
\usepackage{amssymb}  % For more math

\usepackage{blox}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\bXInput{A}
\bXComp{B}{A}
%\bXLink[$R(s)$]{A}{B}
\bXLink{A}{B}
\bXBloc[2]{C}{$K(Ts+1)$}{B}
%\bXLink[$V_1$]{B}{C}
\bXLink{B}{C}
\bXBloc[2]{D}{$\cfrac{1}{s(s+2)}$}{C}
\bXLink{C}{D}
\bXOutput[4]{E}{D}
%\bXLink[$C(s)$]{D}{E}
\bXLink{D}{E}
\bXReturn{D-E}{B}{}
\node (Gc) at (3.5,-0.95) {$G_c(s)$};
\node (Gs) at (5.75,-0.95) {$G(s)$};
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q4Diagram617.png?raw=true "Q4Diagram617")

```tex
\documentclass{standalone}
\usepackage{amsmath}  % For math
\usepackage{amssymb}  % For more math

\usepackage{blox}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\bXInput{A}
\bXComp{B}{A}
%\bXLink[$R(s)$]{A}{B}
\bXLink{A}{B}
\bXBloc[2]{C}{$G_c(s)$}{B}
%\bXLink[$V_1$]{B}{C}
\bXLink{B}{C}
\bXBloc[2]{D}{$\cfrac{5}{s(0.5s+1)}$}{C}
\bXLink{C}{D}
\bXOutput[4]{E}{D}
%\bXLink[$C(s)$]{D}{E}
\bXLink{D}{E}
\bXReturn{D-E}{B}{}
%\node (Gc) at (3.25,-0.95) {$G_c(s)$};
%\node (Gs) at (5.375,-0.95) {$G(s)$};
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q5BlockDiagram.png?raw=true "Q5BlockDiagram")

```tex
\documentclass{standalone}

\usepackage{blox}
\usepackage{tikz}
\usetikzlibrary{positioning}
\newcommand{\equal}{=}
\usepackage{tikz}
\usetikzlibrary{intersections}
\usepackage{tkz-euclide}
% Radius for arc over intersection
\def\radius{1.mm} 

%%%% Adapted from Mark Wibrow
%\tikzset{%
%	connect/.style args={(#1) to (#2) over (#3) by #4}{%
%		insert path={%
%			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, \n2={abs(#4)}  in%
%			(#1) --%
%			($(#1)!\n1-\n2!(#3)$) .. controls +(0:\n2/2) and +(180:\n2/2) ..%
%			+(\n2,#4)%
%			.. controls +(0:\n2/2) and +(180:\n2/2) .. ($(#1)!\n1+\n2!(#3)$) -- (#2)%
%		}%
%	}%
%}

\tikzset{
	connect/.style args={(#1) to (#2) over (#3) by #4}{
		insert path={
			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, 
			\n2={atan2(\y1,\x1)}, \n3={abs(#4)}, \n4={#4>0 ?180:-180}  in 
			(#1) -- ($(#1)!\n1-\n3!(#3)$) 
			arc (\n2:\n2+\n4:\n3) -- (#2)
		}
	},
}

\begin{document}
\begin{tikzpicture}
\bXInput{A}				% Input
\bXComp{B}{A}			% First adder
\bXLink[$R(s)$]{A}{B}	% Input Label
\bXBloc[2]{C}{$G_1$}{B}	% Block G1
\bXLink{B}{C}			% First added -- G1
\bXComp{D}{C}			% Second adder
\bXComp{E}{D}			% Third adder
\bXBranchx[3]{E}{EH1}	% Branch for H1, G2
\bXBloc[2]{EH2}{$G_2$}{EH1}	% Block G2
\bXBranchy[-5]{EH2}{EV2}	% Branch up for H1 -- above G1
\bXBloc[-1.5]{H2}{$H_1$}{EV2}	% Block H1
\bXBranchx[-3.5]{H2}{H2left}	% Branch for H1, G2

\bXBranchx[3]{EH2}{Bran2}		% Branch after G2 and for H2
\bXBranchy[5]{Bran2}{Bran2Down}	% beneath branch 2
\bXBloc[-4.5]{H2Block}{$H_2$}{Bran2Down}
\bXSuma{adder4}{Bran2}
\bXLink{C}{D}
\bXLink{D}{E}
\bXLink{E}{EH2}
\bXLink{EH2}{adder4}		% G2 to adder

\bXBloc[3]{G3Block}{$G_3$}{adder4} % G3
\bXBranchx[4]{G3Block}{BranEnd} % branch before output
\bXBranchy[7.5]{BranEnd}{H3BlockRight} % Right H3 Block
\bXBranchy[2.5]{H3BlockRight}{BranEndReturn} % Right H3 Block
\bXBranchy[7.5]{E}{adder3down} % Below adder3
\bXBloc[-7.5]{H3Block}{$H_3$}{H3BlockRight}	% H3 Block
\draw[-] (BranEnd.center) -- (H3BlockRight.center);
\draw[->] (H3BlockRight.center) -- (H3Block);
\draw[-] (H3BlockRight.center) -- (BranEndReturn.center);
\bXBranchy[10]{B}{adder1Down}
\draw[-] (BranEndReturn.center) -- (adder1Down);

\bXBranchy[5]{D}{adder2down}	% beneath adder2
\bXBranchy[-5]{adder4}{adder4up}		% beneath adder4
%\bXLinkyx{EH1.center}{H2} % -- Connection for branch 1 and H1
\draw[-]  (EH1.center) -- (H2left.center);
\draw[->] (H2left.center) -- (H2);
\draw[->] (Bran2Down.center) -- (H2Block);
\draw[-] (Bran2Down.center) -- (Bran2.center);
\draw[-,name path=H2 to adder2down] (H2Block) -- (adder2down.center); % used in intersection
\draw[->] (adder2down.center) -- (D);
\draw[-]  (H2) -- (adder4up.center);
\draw[->]  (adder4up.center)   -- (adder4);
\draw[->] (adder4) -- (G3Block);

\node[right = 0.5cm of BranEnd] (end) {$C(s)$};
\draw[->] (G3Block) -- (end);

\draw[-] (H3Block) -- (adder3down.center);
\path[name path=line] (adder3down.center) -- (E);
\path[name intersections={of=H2 to adder2down and line,by=inter}];
\draw[->,connect=(adder3down.center) to (E) over (inter) by 3pt ];

\bXLinkxy{BranEndReturn}{B}
 %\bXLinkyx{Bran2}{H2Block}
\end{tikzpicture}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q5BlockDiagram2-2.png?raw=true "Q5BlockDiagram2-2")

```tex
\documentclass{standalone}

\usepackage{blox}
\usepackage{tikz}
\usetikzlibrary{positioning}
\newcommand{\equal}{=}
\usepackage{tikz}
\usetikzlibrary{intersections}
\usepackage{tkz-euclide}
% Radius for arc over intersection
\def\radius{1.mm} 

%%%% Adapted from Mark Wibrow
%\tikzset{%
%	connect/.style args={(#1) to (#2) over (#3) by #4}{%
%		insert path={%
%			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, \n2={abs(#4)}  in%
%			(#1) --%
%			($(#1)!\n1-\n2!(#3)$) .. controls +(0:\n2/2) and +(180:\n2/2) ..%
%			+(\n2,#4)%
%			.. controls +(0:\n2/2) and +(180:\n2/2) .. ($(#1)!\n1+\n2!(#3)$) -- (#2)%
%		}%
%	}%
%}

\tikzset{
	connect/.style args={(#1) to (#2) over (#3) by #4}{
		insert path={
			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, 
			\n2={atan2(\y1,\x1)}, \n3={abs(#4)}, \n4={#4>0 ?180:-180}  in 
			(#1) -- ($(#1)!\n1-\n3!(#3)$) 
			arc (\n2:\n2+\n4:\n3) -- (#2)
		}
	},
}

\begin{document}
\begin{tikzpicture}
\bXInput{A}				% Input
\bXComp{B}{A}			% First adder
\bXLink[$R(s)$]{A}{B}	% Input Label
\bXBloc[2]{C}{$G_1$}{B}	% Block G1
\bXLink{B}{C}			% First added -- G1
\bXComp{D}{C}			% Second adder
\bXComp{E}{D}			% Third adder
\bXBloc[2]{G2}{$G_2$}{E}	% Block G2
\bXBranchx[5]{G2}{G2Right}	% Branch for H1, G2
\bXBranchy[-5]{G2Right}{invG2H1Left}	% node before 1 /G2
\bXBloc[-1.5]{invG2H1}{$\frac{H_1}{G_2}$}{invG2H1Left}	% Block 1/G2
\bXBranchx[-3.5]{invG2H1}{invG2H1left}	% Branch for H1, G2

\bXBranchx[10]{G2}{Bran2}		% Branch after G2 and for H2
\bXBranchy[5]{Bran2}{Bran2Down}	% beneath branch 2
\bXBloc[-4.5]{H2Block}{$H_2$}{Bran2Down}
\bXSuma{adder4}{Bran2}
\bXLink{C}{D}
\bXLink{D}{E}
\bXLink{E}{G2}
\bXLink{G2}{adder4}		% G2 to adder

\bXBloc[3]{G3Block}{$G_3$}{adder4} % G3
\bXBranchx[4]{G3Block}{BranEnd} % branch before output
\bXBranchy[7.5]{BranEnd}{H3BlockRight} % Right H3 Block
\bXBranchy[2.5]{H3BlockRight}{BranEndReturn} % Right H3 Block
\bXBranchy[7.5]{E}{adder3down} % Below adder3
\bXBloc[-7.5]{H3Block}{$H_3$}{H3BlockRight}	% H3 Block
\draw[-] (BranEnd.center) -- (H3BlockRight.center);
\draw[->] (H3BlockRight.center) -- (H3Block);
\draw[-] (H3BlockRight.center) -- (BranEndReturn.center);
\bXBranchy[10]{B}{adder1Down}
\draw[-] (BranEndReturn.center) -- (adder1Down);

\bXBranchy[5]{D}{adder2down}	% beneath adder2
\bXBranchy[-5]{adder4}{adder4up}		% beneath adder4
%\bXLinkyx{EH1.center}{H2} % -- Connection for branch 1 and H1
\draw[->]  (G2Right.center) -- (invG2H1);
%\draw[->] (invG2) -- (H1);
\draw[->] (Bran2Down.center) -- (H2Block);
\draw[-] (Bran2Down.center) -- (Bran2.center);
\draw[-,name path=H2 to adder2down] (H2Block) -- (adder2down.center); % used in intersection
\draw[->] (adder2down.center) -- (D);
\draw[-]  (invG2H1) -- (adder4up.center);
\draw[->]  (adder4up.center)   -- (adder4);
\draw[->] (adder4) -- (G3Block);

\node[right = 0.5cm of BranEnd] (end) {$C(s)$};
\draw[->] (G3Block) -- (end);

\draw[-] (H3Block) -- (adder3down.center);
\path[name path=line] (adder3down.center) -- (E);
\path[name intersections={of=H2 to adder2down and line,by=inter}];
\draw[->,connect=(adder3down.center) to (E) over (inter) by 3pt ];

\bXLinkxy{BranEndReturn}{B}
 %\bXLinkyx{Bran2}{H2Block}
\end{tikzpicture}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q5BlockDiagram2.png?raw=true "Q5BlockDiagram2")

```tex
\documentclass{standalone}

\usepackage{blox}
\usepackage{tikz}
\usetikzlibrary{positioning}
\newcommand{\equal}{=}
\usepackage{tikz}
\usetikzlibrary{intersections}
\usepackage{tkz-euclide}
% Radius for arc over intersection
\def\radius{1.mm} 

%%%% Adapted from Mark Wibrow
%\tikzset{%
%	connect/.style args={(#1) to (#2) over (#3) by #4}{%
%		insert path={%
%			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, \n2={abs(#4)}  in%
%			(#1) --%
%			($(#1)!\n1-\n2!(#3)$) .. controls +(0:\n2/2) and +(180:\n2/2) ..%
%			+(\n2,#4)%
%			.. controls +(0:\n2/2) and +(180:\n2/2) .. ($(#1)!\n1+\n2!(#3)$) -- (#2)%
%		}%
%	}%
%}

\tikzset{
	connect/.style args={(#1) to (#2) over (#3) by #4}{
		insert path={
			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, 
			\n2={atan2(\y1,\x1)}, \n3={abs(#4)}, \n4={#4>0 ?180:-180}  in 
			(#1) -- ($(#1)!\n1-\n3!(#3)$) 
			arc (\n2:\n2+\n4:\n3) -- (#2)
		}
	},
}

\begin{document}
\begin{tikzpicture}
\bXInput{A}				% Input
\bXComp{B}{A}			% First adder
\bXLink[$R(s)$]{A}{B}	% Input Label
\bXBloc[2]{C}{$G_1$}{B}	% Block G1
\bXLink{B}{C}			% First added -- G1
\bXComp{D}{C}			% Second adder
\bXComp{E}{D}			% Third adder
\bXBloc[2]{G2}{$G_2$}{E}	% Block G2
\bXBranchx[5]{G2}{G2Right}	% Branch for H1, G2
\bXBranchy[-5]{G2Right}{invG2Left}	% node before 1 /G2
\bXBloc[-1.5]{invG2}{$\frac{1}{G_2}$}{invG2Left}	% Block 1/G2
\bXBloc[1.5]{H1}{$H_1$}{invG2}	% Block 1/G2
\bXBranchx[-3.5]{H1}{H1left}	% Branch for H1, G2

\bXBranchx[10]{G2}{Bran2}		% Branch after G2 and for H2
\bXBranchy[5]{Bran2}{Bran2Down}	% beneath branch 2
\bXBloc[-4.5]{H2Block}{$H_2$}{Bran2Down}
\bXSuma{adder4}{Bran2}
\bXLink{C}{D}
\bXLink{D}{E}
\bXLink{E}{G2}
\bXLink{G2}{adder4}		% G2 to adder

\bXBloc[3]{G3Block}{$G_3$}{adder4} % G3
\bXBranchx[4]{G3Block}{BranEnd} % branch before output
\bXBranchy[7.5]{BranEnd}{H3BlockRight} % Right H3 Block
\bXBranchy[2.5]{H3BlockRight}{BranEndReturn} % Right H3 Block
\bXBranchy[7.5]{E}{adder3down} % Below adder3
\bXBloc[-7.5]{H3Block}{$H_3$}{H3BlockRight}	% H3 Block
\draw[-] (BranEnd.center) -- (H3BlockRight.center);
\draw[->] (H3BlockRight.center) -- (H3Block);
\draw[-] (H3BlockRight.center) -- (BranEndReturn.center);
\bXBranchy[10]{B}{adder1Down}
\draw[-] (BranEndReturn.center) -- (adder1Down);

\bXBranchy[5]{D}{adder2down}	% beneath adder2
\bXBranchy[-5]{adder4}{adder4up}		% beneath adder4
%\bXLinkyx{EH1.center}{H2} % -- Connection for branch 1 and H1
\draw[->]  (G2Right.center) -- (invG2);
\draw[->] (invG2) -- (H1);
\draw[->] (Bran2Down.center) -- (H2Block);
\draw[-] (Bran2Down.center) -- (Bran2.center);
\draw[-,name path=H2 to adder2down] (H2Block) -- (adder2down.center); % used in intersection
\draw[->] (adder2down.center) -- (D);
\draw[-]  (H1) -- (adder4up.center);
\draw[->]  (adder4up.center)   -- (adder4);
\draw[->] (adder4) -- (G3Block);

\node[right = 0.5cm of BranEnd] (end) {$C(s)$};
\draw[->] (G3Block) -- (end);

\draw[-] (H3Block) -- (adder3down.center);
\path[name path=line] (adder3down.center) -- (E);
\path[name intersections={of=H2 to adder2down and line,by=inter}];
\draw[->,connect=(adder3down.center) to (E) over (inter) by 3pt ];

\bXLinkxy{BranEndReturn}{B}
 %\bXLinkyx{Bran2}{H2Block}
\end{tikzpicture}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q5BlockDiagram3.png?raw=true "Q5BlockDiagram3")

```tex
\documentclass{standalone}

\usepackage{blox}
\usepackage{tikz}
\usetikzlibrary{positioning}
\newcommand{\equal}{=}
\usepackage{tikz}
\usetikzlibrary{intersections}
\usepackage{tkz-euclide}
% Radius for arc over intersection
\def\radius{1.mm} 

%%%% Adapted from Mark Wibrow
%\tikzset{%
%	connect/.style args={(#1) to (#2) over (#3) by #4}{%
%		insert path={%
%			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, \n2={abs(#4)}  in%
%			(#1) --%
%			($(#1)!\n1-\n2!(#3)$) .. controls +(0:\n2/2) and +(180:\n2/2) ..%
%			+(\n2,#4)%
%			.. controls +(0:\n2/2) and +(180:\n2/2) .. ($(#1)!\n1+\n2!(#3)$) -- (#2)%
%		}%
%	}%
%}

\tikzset{
	connect/.style args={(#1) to (#2) over (#3) by #4}{
		insert path={
			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, 
			\n2={atan2(\y1,\x1)}, \n3={abs(#4)}, \n4={#4>0 ?180:-180}  in 
			(#1) -- ($(#1)!\n1-\n3!(#3)$) 
			arc (\n2:\n2+\n4:\n3) -- (#2)
		}
	},
}

\begin{document}
\begin{tikzpicture}
\bXInput{A}				% Input
\bXComp{B}{A}			% First adder
\bXLink[$R(s)$]{A}{B}	% Input Label
\bXBloc[2]{C}{$G_1$}{B}	% Block G1
\bXLink{B}{C}			% First added -- G1
\bXComp{D}{C}			% Second adder
\bXChain[4]{D}%
	{G2Feed/$\frac{G_2}{1+G_2H_2}$,H1G2unity/$1+\frac{H_1}{G_2}$,G3/$G_3$}
\bXLink{C}{D}
%\bXLink{E}{G2}
%\bXLink{G2}{adder4}		% G2 to adder

%\bXBloc[3]{G3Block}{$G_3$}{adder4} % G3
%\bXBranchy[7.5]{BranEnd}{H3BlockRight} % Right H3 Block
%\bXBranchy[2.5]{H3BlockRight}{BranEndReturn} % Right H3 Block

\bXBranchx[3]{G3}{BranEnd} % branch before output
\bXBranchy[5]{BranEnd}{H3BlockRight} %H3BlockRight

\bXBloc[-7.5]{H3Block}{$H_3$}{H3BlockRight}	% H3 Block
\bXBranchy[2.5]{H3BlockRight}{returnToInputRight}
\bXBranchy[7.5]{B}{adder1Down}
\draw[-] (BranEnd.center) -- (H3BlockRight.center);
\draw[->] (H3BlockRight.center) -- (H3Block);



\node[right = 0.5cm of BranEnd] (end) {$C(s)$};
\draw[->] (G3) -- (end);

%H3 to second adder
\bXLinkxy{H3Block}{D}
%Output back to input, feedback loop
\draw[-] (H3BlockRight.center) -- (returnToInputRight.center);
\draw[-] (returnToInputRight.center) -- (adder1Down.center);
\draw[->] (adder1Down.center)  -- (B);
%\draw[-] (H3Block) -- (adder3down.center);
%\path[name path=line] (adder3down.center) -- (E);
%\path[name intersections={of=H2 to adder2down and line,by=inter}];
%\draw[->,connect=(adder3down.center) to (E) over (inter) by 3pt ];

%\bXLinkxy{BranEndReturn}{B}
 %\bXLinkyx{Bran2}{H2Block}
\end{tikzpicture}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q5BlockDiagram4.png?raw=true "Q5BlockDiagram4")

```tex
\documentclass{standalone}
\usepackage{amsmath}  % For math
\usepackage{amssymb}  % For more math

\usepackage{blox}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\bXInput{A}
\bXComp{B}{A}
\bXLink[$R(s)$]{A}{B}
\bXBloc[2]{C}{$\cfrac{G_1G_3(G_2+H_1)}{1+G_2H_2+H_3G_3(G_2+H_1)}$}{B}
\bXLink[$V_1$]{B}{C}
\bXOutput{E}{C}
\bXLink[$C(s)$]{C}{E}
\bXReturn{C-E}{B}{}
\end{tikzpicture}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q5BlockDiagram5.png?raw=true "Q5BlockDiagram5")

```tex
\documentclass{standalone}
\usepackage{amsmath}  % For math
\usepackage{amssymb}  % For more math

\usepackage{blox}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\bXInput{A}
\bXBloc[4]{C}{$\cfrac{G_1G_2G_3+G_1G_3H_1}{1+G_2H_2+H_3G_2G_3+H_1H_2G_3+G_1G_2G_3+G_1G_3H_1}$}{A}
\bXOutput[4]{E}{C}
\bXLink[$R(s) \quad $]{A}{C}
\bXLink[$\quad C(s)$]{C}{E}
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q5BlockDiagram6.png?raw=true "Q5BlockDiagram6")

```tex
\documentclass{standalone}
\usepackage{amsmath}  % For math
\usepackage{amssymb}  % For more math

\usepackage{blox}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\bXInput{A}
\bXBloc[4]{C}{$\cfrac{G_3(G_2+H_1)}{1+G_2H_2+H_3G_3(G_2+H_1)}$}{A}
\bXOutput[4]{E}{C}
\bXLink[$R(s) \quad $]{A}{C}
\bXLink[$\quad C(s)$]{C}{E}
\end{tikzpicture}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q5Diagram620.png?raw=true "Q5Diagram620")

```tex
\documentclass{standalone}
\usepackage{amsmath}  % For math
\usepackage{amssymb}  % For more math

\usepackage{blox}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\bXInput{A}
\bXComp{B}{A}
%\bXLink[$R(s)$]{A}{B}
\bXLink{A}{B}
\bXBloc[2]{C}{$G_c(s)$}{B}
%\bXLink[$V_1$]{B}{C}
\bXLink{B}{C}
\bXBloc[2]{D}{$\cfrac{820}{s(s+10)(s+20)}$}{C}
\bXLink{C}{D}
\bXOutput[4]{E}{D}
%\bXLink[$C(s)$]{D}{E}
\bXLink{D}{E}
\bXReturn{D-E}{B}{}
%\node (Gc) at (3.25,-0.95) {$G_c(s)$};
%\node (Gs) at (5.375,-0.95) {$G(s)$};
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q6BlockDiagram.png?raw=true "Q6BlockDiagram")

```tex
\documentclass{standalone}

\usepackage{blox}
\usepackage{tikz}
\usetikzlibrary{positioning}
\newcommand{\equal}{=}
\usepackage{tikz}
\usetikzlibrary{intersections}
\usepackage{tkz-euclide}
% Radius for arc over intersection
\def\radius{1.mm} 

%%%% Adapted from Mark Wibrow
%\tikzset{%
%	connect/.style args={(#1) to (#2) over (#3) by #4}{%
%		insert path={%
%			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, \n2={abs(#4)}  in%
%			(#1) --%
%			($(#1)!\n1-\n2!(#3)$) .. controls +(0:\n2/2) and +(180:\n2/2) ..%
%			+(\n2,#4)%
%			.. controls +(0:\n2/2) and +(180:\n2/2) .. ($(#1)!\n1+\n2!(#3)$) -- (#2)%
%		}%
%	}%
%}

\tikzset{
	connect/.style args={(#1) to (#2) over (#3) by #4}{
		insert path={
			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, 
			\n2={atan2(\y1,\x1)}, \n3={abs(#4)}, \n4={#4>0 ?180:-180}  in 
			(#1) -- ($(#1)!\n1-\n3!(#3)$) 
			arc (\n2:\n2+\n4:\n3) -- (#2)
		}
	},
}

\begin{document}
\begin{tikzpicture}
\bXInput{input}				% Input
\bXComp{adder1}{input}			% First adder
\bXLink[$R(s)$]{input}{adder1}	% Input Label
\bXBloc[1.5]{Gc}{$G_c$}{adder1}			%BLock Gc
\bXComp{adder2}{Gc}		% second adder
\bXBloc[1.5]{G1}{$G_1$}{adder2}	% G1 Block
\bXSuma{adder3}{G1}			% third adder --suma variant
\bXBloc[1.5]{G2}{$G_2$}{adder3}	% G2 Block
\bXBranchy[-4.5]{adder3}{adder3up3} % adder3 up 3 units
\bXLink[$D(s)$]{adder3up3}{adder3}

\bXBranchx[3]{G2}{G2Right15}		% Right of G2 1.5 units	
\bXBloc[1.5]{G3}{$G_3$}{G2Right15}		% G3 Block
\bXBranchx[3.5]{G3}{G3Right15}		% Right of G3 1.5 units
\bXBranchy[4.5]{G2Right15}{G2Right15Down3}	% Right from G2 1.5 units right and 3 units down
\bXBloc[-9]{H1}{$H_1$}{G2Right15Down3}	% H1 Block
\bXBranchy[10]{G3Right15}{outputDown10}

\bXBloc[-15.5]{H2}{$H_2$}{outputDown10}
\bXOutput[3]{end}{G3Right15}

%%Drawing most of the connecters here
\draw[->] (adder1) -- (Gc);
\draw[->] (Gc) -- (adder2);
\draw[->] (adder2) -- (G1);
\draw[->] (G1)  -- (adder3);
\draw[->] (adder3) -- (G2);
\draw[-] (G3) -- (end);
\draw[-] (G2Right15.center) -- (G2Right15Down3.center);
\draw[-] (G3Right15.center) -- (outputDown10.center);
\draw[->] (outputDown10.center) -- (H2);
\draw[->] (G2) -- (G3); % Connect G2 and G3
\draw[->] (G2Right15Down3.center)  -- (H1);

\bXLinkxy{H2}{adder1}
\bXLink[$C(s)$]{G3Right15}{end}	% Output Label
\bXLinkxy{H1}{adder2}
\end{tikzpicture}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q6BLockDiagram2.png?raw=true "Q6BLockDiagram2")

```tex
\documentclass{standalone}

\usepackage{blox}
\usepackage{tikz}
\usetikzlibrary{positioning}
\newcommand{\equal}{=}
\usepackage{tikz}



\begin{document}

\begin{tikzpicture}
\bXInput{A}
\bXComp{B}{A}
\bXLink[$R(s)$]{A}{B}
\bXChain[2]{B}%
{Gc/$\frac{G_c}{1+G_2H_2}$,G1G2Feed/$\frac{G_1G_2}{1+G_1G_2H_1}$,G3/$G_3$}
\bXOutput[4]{E}{G3}
\bXLink[$C(s)$]{G3}{E}
\bXBranchy[5]{G3}{returnDown}

% return loop
\bXBlocr[5]{H2}{$H_2$}{returnDown}\bXLinkyx{G3-E}{H2}
\bXLinkxy{H2}{B}

%\bXReturn{G3-E}{B}{}
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q6BLockDiagram3Fin.png?raw=true "Q6BLockDiagram3Fin")

```tex
\documentclass{standalone}
\usepackage{amsmath}  % For math
\usepackage{amssymb}  % For more math

\usepackage{blox}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\bXInput{A}
\bXBloc[4]{C}{$\cfrac{G_cG_3G_1G_2}{1+G_1G_2H_1+G_cG_3G_1G_2}$}{A}
\bXOutput[4]{E}{C}
\bXLink[$R(s) \quad $]{A}{C}
\bXLink[$\quad C(s)$]{C}{E}
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q6BlockDiagram4.png?raw=true "Q6BlockDiagram4")

```tex
\documentclass{standalone}

\usepackage{blox}
\usepackage{tikz}
\usetikzlibrary{positioning}
\newcommand{\equal}{=}
\usepackage{tikz}
\usetikzlibrary{intersections}
\usepackage{tkz-euclide}
% Radius for arc over intersection
\def\radius{1.mm} 

%%%% Adapted from Mark Wibrow
%\tikzset{%
%	connect/.style args={(#1) to (#2) over (#3) by #4}{%
%		insert path={%
%			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, \n2={abs(#4)}  in%
%			(#1) --%
%			($(#1)!\n1-\n2!(#3)$) .. controls +(0:\n2/2) and +(180:\n2/2) ..%
%			+(\n2,#4)%
%			.. controls +(0:\n2/2) and +(180:\n2/2) .. ($(#1)!\n1+\n2!(#3)$) -- (#2)%
%		}%
%	}%
%}

\tikzset{
	connect/.style args={(#1) to (#2) over (#3) by #4}{
		insert path={
			let \p1=($(#1)-(#3)$), \n1={veclen(\x1,\y1)}, 
			\n2={atan2(\y1,\x1)}, \n3={abs(#4)}, \n4={#4>0 ?180:-180}  in 
			(#1) -- ($(#1)!\n1-\n3!(#3)$) 
			arc (\n2:\n2+\n4:\n3) -- (#2)
		}
	},
}

\begin{document}
\begin{tikzpicture}
\bXInput{input}				% Input
%\bXBranchx[0]{input}{GcLeft}
%\bXComp{adder1}{input}			% First adder
%\bXLink[$R(s)$]{input}{adder1}	% Input Label
\bXBloc[1.5]{Gc}{$G_c$}{input}			%BLock Gc
\bXSumb{adder2}{Gc}		% second adder
\bXBloc[1.5]{G1}{$G_1$}{adder2}	% G1 Block
\bXCompSum{adder3}{G1}{+}{}{-}{}		% third adder --suma variant
\bXBloc[1.5]{G2}{$G_2$}{adder3}	% G2 Block
\bXBranchy[-4.5]{adder3}{adder3up3} % adder3 up 3 units
\bXLink[$D(s)$]{adder3up3}{adder3}

%\bXBranchx[3]{G2}{G2Right15}		% Right of G2 1.5 units	
\bXBloc[1.5]{G3}{$G_3$}{G2}		% G3 Block
\bXBranchx[3.5]{G3}{G3Right15}		% Right of G3 1.5 units
\bXBranchy[4.5]{G3Right15}{invG3Right}	% Right from G2 1.5 units right and 3 units down
\bXBloc[-9]{invG3}{$\frac{1}{G_3}$}{invG3Right}	% H1 Block
\bXBloc[-9]{H1}{$H_1$}{invG3}	% H1 Block
\bXBranchy[10]{G3Right15}{outputDown10}

\bXBloc[-15.5]{H2}{$H_2$}{outputDown10}
\bXOutput[3]{end}{G3Right15}

\draw[->] (Gc) -- (adder2);
\draw[->] (adder2) -- (G1);
\draw[->] (G1)  -- (adder3);
\draw[->] (adder3) -- (G2);
\draw[-] (G3) -- (end);
%\draw[-] (G2Right15.center) -- (G2Right15Down3.center);
\draw[-] (G3Right15.center) -- (outputDown10.center);
\draw[->] (outputDown10.center) -- (H2);
\draw[->] (G2) -- (G3); % Connect G2 and G3
\draw[->] (invG3Right.center) -- (invG3);
\draw[->] (invG3) -- (H1);
\bXLinkxy{H2}{Gc}
\bXLink[$C(s)$]{G3Right15}{end}	% Output Label
\bXLinkxy{H1}{adder2}
\end{tikzpicture}
\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q6BlockDiagram5.png?raw=true "Q6BlockDiagram5")

```tex
\documentclass{standalone}

\usepackage{blox}
\usepackage{tikz}
\usepackage{amsmath}  % For math
\usetikzlibrary{positioning}
\newcommand{\equal}{=}
\usepackage{tikz}



\begin{document}

\begin{tikzpicture}
\bXInput{A}
\bXComp{B}{A}
\bXLink[$D(s)$]{A}{B}
\bXChain[5]{B}%
{G2G3/$G_2G_3$}
\bXOutput[7.5]{E}{G2G3}
\bXLink[$C(s)$]{G2G3}{E}
\bXBranchy[5]{E}{returnDown}

% return loop
\bXBlocr[3]{GcBlock}{$G_cH_2+\frac{H_1}{G_3}$}{returnDown}
\bXBlocr[3]{G1}{$G_1$}{GcBlock}
\bXLink{GcBlock}{G1}
\bXLinkxy{G1}{B}
\bXLinkxy{E}{GcBlock}
%\bXReturn{G3-E}{B}{}
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/Q6BlockDiagram6fin.png?raw=true "Q6BlockDiagram6fin")

```tex
\documentclass{standalone}
\usepackage{amsmath}  % For math
\usepackage{amssymb}  % For more math

\usepackage{blox}
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\bXInput{A}
\bXBloc[4]{C}{$\cfrac{G_2G_3}{1+G_1G_2G_3G_cH_2+G_1G_2H_1}$}{A}
\bXOutput[4]{E}{C}
\bXLink[$R(s) \quad $]{A}{C}
\bXLink[$\quad C(s)$]{C}{E}
\end{tikzpicture}

\end{document}
```
![ControlSystems/CSI](ControlSystems/CSI/RootLocusAdd.png?raw=true "RootLocusAdd")

```tex
\documentclass[]{article}
\usepackage{lmodern}
\usepackage{amssymb,amsmath}
\usepackage{ifxetex,ifluatex}
\usepackage{fixltx2e} % provides \textsubscript
\ifnum 0\ifxetex 1\fi\ifluatex 1\fi=0 % if pdftex
  \usepackage[T1]{fontenc}
  \usepackage[utf8]{inputenc}
\else % if luatex or xelatex
  \ifxetex
    \usepackage{mathspec}
  \else
    \usepackage{fontspec}
  \fi
  \defaultfontfeatures{Ligatures=TeX,Scale=MatchLowercase}
\fi
% use upquote if available, for straight quotes in verbatim environments
\IfFileExists{upquote.sty}{\usepackage{upquote}}{}
% use microtype if available
\IfFileExists{microtype.sty}{%
\usepackage[]{microtype}
\UseMicrotypeSet[protrusion]{basicmath} % disable protrusion for tt fonts
}{}
\PassOptionsToPackage{hyphens}{url} % url is loaded by hyperref
\usepackage[unicode=true]{hyperref}
\hypersetup{
            pdftitle={The Root Locus Rules},
            pdfkeywords={weblatex},
            pdfborder={0 0 0},
            breaklinks=true}
\urlstyle{same}  % don't use monospace font for urls
\usepackage{graphicx,grffile}
\makeatletter
\def\maxwidth{\ifdim\Gin@nat@width>\linewidth\linewidth\else\Gin@nat@width\fi}
\def\maxheight{\ifdim\Gin@nat@height>\textheight\textheight\else\Gin@nat@height\fi}
\makeatother
% Scale images if necessary, so that they will not overflow the page
% margins by default, and it is still possible to overwrite the defaults
% using explicit options in \includegraphics[width, height, ...]{}
\setkeys{Gin}{width=\maxwidth,height=\maxheight,keepaspectratio}
\IfFileExists{parskip.sty}{%
\usepackage{parskip}
}{% else
\setlength{\parindent}{0pt}
\setlength{\parskip}{6pt plus 2pt minus 1pt}
}
\setlength{\emergencystretch}{3em}  % prevent overfull lines
\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}
\setcounter{secnumdepth}{0}
% Redefines (sub)paragraphs to behave more like sections
\ifx\paragraph\undefined\else
\let\oldparagraph\paragraph
\renewcommand{\paragraph}[1]{\oldparagraph{#1}\mbox{}}
\fi
\ifx\subparagraph\undefined\else
\let\oldsubparagraph\subparagraph
\renewcommand{\subparagraph}[1]{\oldsubparagraph{#1}\mbox{}}
\fi

% set default figure placement to htbp
\makeatletter
\def\fps@figure{htbp}
\makeatother


\title{The Root Locus Rules}
\date{}

\begin{document}
\maketitle

\begin{center}\rule{0.5\linewidth}{\linethickness}\end{center}

\emph{Kent H Lundberg}\\
\emph{2002-11-14}

\end{document}

```
![ControlSystems/CSI](ControlSystems/CSI/timeline.png?raw=true "timeline")

```tex
\documentclass{standalone}
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{charter}
\usepackage{environ}
\usepackage{tikz}
\usetikzlibrary{calc,matrix}

% code by Andrew:
% http://tex.stackexchange.com/a/28452/13304
\makeatletter
\let\matamp=&
\catcode`\&=13
\makeatletter
\def&{\iftikz@is@matrix
  \pgfmatrixnextcell
  \else
  \matamp
  \fi}
\makeatother

\newcounter{lines}
\def\endlr{\stepcounter{lines}\\}

\newcounter{vtml}
\setcounter{vtml}{0}

\newif\ifvtimelinetitle
\newif\ifvtimebottomline
\tikzset{description/.style={
  column 2/.append style={#1}
 },
 timeline color/.store in=\vtmlcolor,
 timeline color=red!80!black,
 timeline color st/.style={fill=\vtmlcolor,draw=\vtmlcolor},
 use timeline header/.is if=vtimelinetitle,
 use timeline header=false,
 add bottom line/.is if=vtimebottomline,
 add bottom line=false,
 timeline title/.store in=\vtimelinetitle,
 timeline title={},
 line offset/.store in=\lineoffset,
 line offset=4pt,
}

\NewEnviron{vtimeline}[1][]{%
\setcounter{lines}{1}%
\stepcounter{vtml}%
\begin{tikzpicture}[column 1/.style={anchor=east},
 column 2/.style={anchor=west},
 text depth=0pt,text height=1ex,
 row sep=1ex,
 column sep=1em,
 #1
]
\matrix(vtimeline\thevtml)[matrix of nodes]{\BODY};
\pgfmathtruncatemacro\endmtx{\thelines-1}
\path[timeline color st] 
($(vtimeline\thevtml-1-1.north east)!0.5!(vtimeline\thevtml-1-2.north west)$)--
($(vtimeline\thevtml-\endmtx-1.south east)!0.5!(vtimeline\thevtml-\endmtx-2.south west)$);
\foreach \x in {1,...,\endmtx}{
 \node[circle,timeline color st, inner sep=0.15pt, draw=white, thick] 
 (vtimeline\thevtml-c-\x) at 
 ($(vtimeline\thevtml-\x-1.east)!0.5!(vtimeline\thevtml-\x-2.west)$){};
 \draw[timeline color st](vtimeline\thevtml-c-\x.west)--++(-3pt,0);
 }
 \ifvtimelinetitle%
  \draw[timeline color st]([yshift=\lineoffset]vtimeline\thevtml.north west)--
  ([yshift=\lineoffset]vtimeline\thevtml.north east);
  \node[anchor=west,yshift=16pt,font=\large]
   at (vtimeline\thevtml-1-1.north west) 
   {\textsc{Timeline \thevtml}: \textit{\vtimelinetitle}};
 \else%
  \relax%
 \fi%
 \ifvtimebottomline%
   \draw[timeline color st]([yshift=-\lineoffset]vtimeline\thevtml.south west)--
  ([yshift=-\lineoffset]vtimeline\thevtml.south east);
 \else%
   \relax%
 \fi%
\end{tikzpicture}
}

\begin{document}

%\begin{vtimeline}[description={text width=7cm}, 
% row sep=4ex, 
% use timeline header,
% timeline title={The title}]
%1947 & AT and T Bell Labs develop the idea of cellular phones\endlr
%1968 & Xerox Palo Alto Research Centre envisage the `Dynabook'\endlr
%1971 & Busicom 'Handy-LE' Calculator\endlr
%1973 & First mobile handset invented by Martin Cooper\endlr
%1978 & Parker Bros. Merlin Computer Toy\endlr
%1981 & Osborne 1 Portable Computer\endlr
%1982 & Grid Compass 1100 Clamshell Laptop\endlr
%1983 & TRS-80 Model 100 Portable PC\endlr
%1984 & Psion Organiser Handheld Computer\endlr
%1991 & Psion Series 3 Minicomputer\endlr
%\end{vtimeline}

\begin{vtimeline}[timeline color=cyan!80!blue, add bottom line, line offset=2pt]
Sept 4 2017 & Discussed Making Unity Games and worked on Tutorials \endlr
Sept 16 2017 & Finish Chapter 1 \& 2, latex slides \endlr
October 3 & Completed a few labs \endlr
1973 & First mobile handset invented by Martin Cooper\endlr
1978 & Parker Bros. Merlin Computer Toy\endlr
1981 & Osborne 1 Portable Computer\endlr
1982 & Grid Compass 1100 Clamshell Laptop\endlr
1983 & TRS-80 Model 100 Portable PC\endlr
1984 & Psion Organiser Handheld Computer\endlr
1991 & Psion Series 3 Minicomputer\endlr
\end{vtimeline}

\end{document}
```
# ControlSystems/CSII

![ControlSystems/CSII](ControlSystems/CSII/460A3SamplerTesting.png?raw=true "460A3SamplerTesting")

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
![ControlSystems/CSII](ControlSystems/CSII/B48RLocus.png?raw=true "B48RLocus")

```tex
   \documentclass{standalone}
   \usepackage{pgfplots}
   % Manually removed entries to plot a "better" root locus in latex, of course using matlab 2 tikz is much better.
   \pgfplotsset{compat=1.11}
   \pgfplotstableread{
   	pr1 		 pi1 	  pr2 		pi2 		k
    1.0000         0    0.6065         0         0
    0.9272         0    0.6672         0    0.0121
    0.9109         0    0.6814         0    0.0142
    0.8887         0    0.7011         0    0.0166
    0.8541         0    0.7329         0    0.0195
    0.7987         0    0.7863         0    0.0215
    0.7925   -0.0000    0.7925    0.0000    0.0215
    0.7925   -0.0062    0.7925    0.0062    0.0216
    0.7918   -0.0482    0.7918    0.0482    0.0228
    0.7899   -0.0967    0.7899    0.0967    0.0268
    0.7876   -0.1326    0.7876    0.1326    0.0313
    0.7849   -0.1649    0.7849    0.1649    0.0367
    0.7817   -0.1961    0.7817    0.1961    0.0430
    0.7780   -0.2272    0.7780    0.2272    0.0504
    0.7737   -0.2588    0.7737    0.2588    0.0591
    0.7686   -0.2915    0.7686    0.2915    0.0693
    0.7627   -0.3255    0.7627    0.3255    0.0812
    0.7557   -0.3613    0.7557    0.3613    0.0951
    0.7475   -0.3989    0.7475    0.3989    0.1114
    0.7380   -0.4387    0.7380    0.4387    0.1306
    0.7267   -0.4810    0.7267    0.4810    0.1530
    0.7136   -0.5259    0.7136    0.5259    0.1793
    0.6982   -0.5737    0.6982    0.5737    0.2101
    0.6802   -0.6245    0.6802    0.6245    0.2462
    0.6590   -0.6787    0.6590    0.6787    0.2885
    0.6342   -0.7364    0.6342    0.7364    0.3380
    0.6052   -0.7977    0.6052    0.7977    0.3961
    0.5712   -0.8628    0.5712    0.8628    0.4641
    0.5313   -0.9317    0.5313    0.9317    0.5439
    0.4846   -1.0045    0.4846    1.0045    0.6373
    0.4299   -1.0810    0.4299    1.0810    0.7468
    0.3657   -1.1610    0.3657    1.1610    0.8751
    0.2906   -1.2440    0.2906    1.2440    1.0254
    0.2025   -1.3293    0.2025    1.3293    1.2015
    0.0993   -1.4158    0.0993    1.4158    1.4079
    -0.0217   -1.5019   -0.0217    1.5019    1.6498
    -0.1634   -1.5853   -0.1634    1.5853    1.9332
    -0.3294   -1.6623   -0.3294    1.6623    2.2653
    -0.5240   -1.7281   -0.5240    1.7281    2.6545
    -0.7520   -1.7752   -0.7520    1.7752    3.1105
    -1.0192   -1.7924   -1.0192    1.7924    3.6449
    -1.3323   -1.7614   -1.3323    1.7614    4.2710
    -1.5157   -1.7167   -1.5157    1.7167    4.6379
    -1.6991   -1.6505   -1.6991    1.6505    5.0047
    -1.9140   -1.5419   -1.9140    1.5419    5.4346
    -2.1290   -1.3923   -2.1290    1.3923    5.8645
    -2.3809   -1.1429   -2.3809    1.1429    6.3682
    -2.5068   -0.9709   -2.5068    0.9709    6.6201
    -2.6327   -0.7398   -2.6327    0.7398    6.8719
    -2.7108   -0.5349   -2.7108    0.5349    7.0281
    -2.7498   -0.3886   -2.7498    0.3886    7.1062
    -2.7889   -0.1135   -2.7889    0.1135    7.1843
    -2.7925   -0.0000   -2.7925    0.0000    7.1915
    -2.6825         0   -2.9097         0    7.1987
    -1.9082         0   -4.5377         0    8.0524
}\mytable

\begin{document}

\begin{tikzpicture}[
%This is to provide the start  point cross marker 
start marker/.pic={\draw (-#1,-#1) -- (#1,#1) (#1,-#1)--(-#1,#1);}
]
\begin{axis}[no marks,xmax=2,grid=both]% Don't put any markers, limit the visible area from one side ,draw grid
\foreach\x in{1,...,2}{% Iterate over the columns of the table
	\addplot+[] table[x=pr\x,y=pi\x] {\mytable} % Draw the curves
	node[draw,circle,inner sep=2pt] at (current plot end) {}%Put the ending marker with size adjusted to 2pt
	pic at (current plot begin) {start marker=2pt};%Put the starting marker
}
\end{axis}
\end{tikzpicture}
\end{document}
```
![ControlSystems/CSII](ControlSystems/CSII/block410.png?raw=true "block410")

```tex

\documentclass[%
% border=1pt
border={-25pt 0pt 0pt 0pt} % left bottom right top
]{standalone}
\usepackage{tikz}
\usepackage{amsmath}
\usetikzlibrary{positioning}
\usetikzlibrary{shapes,arrows,calc} 
\usetikzlibrary{decorations.text}
\usetikzlibrary{decorations.pathreplacing}
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
	%\tikzstyle{block} = [draw, fill=blue!20, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{block} = [draw, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{controller} = [draw, fill=red!20, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{sum} = [draw, fill=blue!20, circle, node distance=1cm]
	\tikzstyle{input} = [coordinate]
	\tikzstyle{output} = [coordinate]
	\tikzstyle{sampleSP} = [coordinate]
	\tikzstyle{sampleEP} = [coordinate]
	\tikzstyle{otherPoint} = [coordinate]
	\tikzset{
		position label/.style={
			below = 3pt,
			text height = 1.5ex,
			text depth = 1ex
		},
		brace/.style={
			decoration={brace, mirror},
			decorate
		}
	}
	\begin{tikzpicture}[auto, >=latex']
	% Nodes
	\node [input] (input) {};
	%\node [sum, right = 1cm of input] (sum) {};
	\node[draw,circle,add={--}{+}{}{},right of= input](sum){}; 
	\node [sampleSP, right = 1cm of sum] (sumSP) {};
	\node [sampleEP, right = 1cm of sumSP] (sumEP) {};
	\node [sampleEP, above = 1cm of sumEP] (sumEPTOP) {};
	\node [block, right = 1cm of sumEP,text width=1.75cm,align=center] (systemK) {Digital PI Controller};
	\node [block, right = 1cm of systemK] (systemZOH) {$\cfrac{1-e^{-s}}{s}$};
	\node [block, right = 1cm of systemZOH] (system) {$\cfrac{10}{(s+1)(s+5)}$};
	\node [otherPoint,right = 1cm of system] (branchPoint) {};
	\node [otherPoint,below = 1 cm of system] (belowsystem) {}; %{$\frac{1}{Ts+1}$};
	%\node [block, right = 1cm of system] (system2) {$\frac{1}{Ts+1}$};
	\node [output, right = 1cm of branchPoint] (output) {};
	\node [input, below = 2cm of system] (m) {};

	% Arrows
	\draw [draw,->] (input) -- node {$R$} (sum);
	% Arrows for first sampler
	\draw [-] (sum) -- node {$E(s)$} (sumSP);
	\draw [-,thick] (sumEPTOP) -- node {$\delta_\tau$} (sumSP);
	\draw [->] (sumEP) -- node {$E^\ast(s)$} (systemK);
	\draw [->] (systemK) -- node {} (systemZOH);
	\draw [->] (systemZOH) -- node {} (system);
	%\draw [->] (sumEP) -- node {$M^\ast(s)$} (systemH);
	% \draw [->] (system) --  (system2);
	\draw [-] (system) --  (branchPoint);
	\draw [->] (branchPoint) -- node (y) {$C(s)$}(output);

	\draw [-] (y) |- (m) {} ;
	\draw [->] (m) -| (sum); %{$-$}  node [near end] {} (sum);
	%\node [below = 0.005 cm of system] (PointHeader) {\scriptsize{$G(s)$}};
	\draw[thick,dotted]     ($(systemZOH.north west)+(-0.25,0.15)$) rectangle ($(system.south east)+(0.25,-0.15)$);
	\draw [brace,decoration={raise=2ex}] (systemZOH.south west) -- node [position label,yshift=-2ex] {$G(s)$} (system.south east);
	\end{tikzpicture}
%\end{figure}
\end{document}
```
![ControlSystems/CSII](ControlSystems/CSII/block412.png?raw=true "block412")

```tex

\documentclass[%
% border=1pt
border={-25pt 0pt 0pt 0pt} % left bottom right top
]{standalone}
\usepackage{tikz}
\usepackage{amsmath}
\usetikzlibrary{positioning}
\usetikzlibrary{shapes,arrows,calc} 
\usetikzlibrary{decorations.text}
\usetikzlibrary{decorations.pathreplacing}
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
	\tikzset{
		position label/.style={
			below = 3pt,
			text height = 1.5ex,
			text depth = 1ex
		},
		brace/.style={
			decoration={brace, mirror},
			decorate
		}
	}
	\begin{tikzpicture}[auto, >=latex']
	% Nodes
	\node [input] (input) {};
	%\node [sum, right = 1cm of input] (sum) {};
	\node[draw,circle,add={--}{+}{}{},right of= input](sum){}; 
	\node [sampleSP, right = 1cm of sum] (sumSP) {};
	\node [sampleEP, right = 1cm of sumSP] (sumEP) {};
	\node [sampleEP, above = 1cm of sumEP] (sumEPTOP) {};
	\node [block, right = 1cm of sumEP,text width=1.75cm,align=center] (systemK) {Digital PD Controller};
	\node [block, right = 1cm of systemK] (systemZOH) {$\cfrac{1-e^{-s}}{s}$};
	\node [controller, right = 1cm of systemZOH] (system) {$\cfrac{1}{s^2}$};
	\node [otherPoint,right = 1cm of system] (branchPoint) {};
	\node [otherPoint,below = 1 cm of system] (belowsystem) {}; %{$\frac{1}{Ts+1}$};
	%\node [block, right = 1cm of system] (system2) {$\frac{1}{Ts+1}$};
	\node [output, right = 1cm of branchPoint] (output) {};
	\node [input, below = 2cm of system] (m) {};

	% Arrows
	\draw [draw,->] (input) -- node {$R$} (sum);
	% Arrows for first sampler
	\draw [-] (sum) -- node {$E(s)$} (sumSP);
	\draw [-,thick] (sumEPTOP) -- node {$\delta_\tau$} (sumSP);
	\draw [->] (sumEP) -- node {$E^\ast(s)$} (systemK);
	\draw [->] (systemK) -- node {} (systemZOH);
	\draw [->] (systemZOH) -- node {} (system);
	%\draw [->] (sumEP) -- node {$M^\ast(s)$} (systemH);
	% \draw [->] (system) --  (system2);
	\draw [-] (system) --  (branchPoint);
	\draw [->] (branchPoint) -- node (y) {$C(s)$}(output);

	\draw [-] (y) |- (m) {} ;
	\draw [->] (m) -| (sum); %{$-$}  node [near end] {} (sum);
	%\node [below = 0.005 cm of system] (PointHeader) {\scriptsize{$G(s)$}};
	\draw[thick,dotted]     ($(systemZOH.north west)+(-0.25,0.15)$) rectangle ($(system.south east)+(0.25,-0.15)$);
	\draw [brace,decoration={raise=2ex}] (systemZOH.south west) -- node [position label,yshift=-2ex] {$G(s)$} (system.south east);
	\end{tikzpicture}
%\end{figure}
\end{document}
```
![ControlSystems/CSII](ControlSystems/CSII/block415.png?raw=true "block415")

```tex

\documentclass[%
% border=1pt
border={-25pt 0pt 0pt 0pt} % left bottom right top
]{standalone}
\usepackage{tikz}
\usepackage{amsmath}
\usetikzlibrary{positioning}
\usetikzlibrary{shapes,arrows,calc} 
\usetikzlibrary{decorations.text}
\usetikzlibrary{decorations.pathreplacing}
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
	%\tikzstyle{block} = [draw, fill=blue!20, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{block} = [draw, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{controller} = [draw, fill=red!20, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{sum} = [draw, fill=blue!20, circle, node distance=1cm]
	\tikzstyle{input} = [coordinate]
	\tikzstyle{output} = [coordinate]
	\tikzstyle{sampleSP} = [coordinate]
	\tikzstyle{sampleEP} = [coordinate]
	\tikzstyle{otherPoint} = [coordinate]
	\tikzset{
		position label/.style={
			below = 3pt,
			text height = 1.5ex,
			text depth = 1ex
		},
		brace/.style={
			decoration={brace, mirror},
			decorate
		}
	}
	\begin{tikzpicture}[auto, >=latex']
	% Nodes
	\node [input] (input) {};
	%\node [sum, right = 1cm of input] (sum) {};
	\node[draw,circle,add={--}{+}{}{},right of= input](sum){}; 
	\node [sampleSP, right = 1cm of sum] (sumSP) {};
	\node [sampleEP, right = 1cm of sumSP] (sumEP) {};
	\node [sampleEP, above = 1cm of sumEP] (sumEPTOP) {};
	\node [block, right = 1cm of sumEP,text width=1.75cm,align=center] (systemK) {$G_D(z)$};
	\node [block, right = 1cm of systemK] (systemZOH) {$\cfrac{1-e^{-s}}{s}$};
	\node [block, right = 1cm of systemZOH] (system) {$\cfrac{K}{(s)(s+0.5)}$};
	\node [otherPoint,right = 1cm of system] (branchPoint) {};
	\node [otherPoint,below = 1 cm of system] (belowsystem) {}; %{$\frac{1}{Ts+1}$};
	%\node [block, right = 1cm of system] (system2) {$\frac{1}{Ts+1}$};
	\node [output, right = 1cm of branchPoint] (output) {};
	\node [input, below = 2cm of system] (m) {};

	% Arrows
	\draw [draw,->] (input) -- node {$R$} (sum);
	% Arrows for first sampler
	%\draw [-] (sum) -- node {$E(s)$} (sumSP);
	\draw [-] (sum) -- node {} (sumSP);
	\draw [-,thick] (sumEPTOP) -- node {$T$} (sumSP);
	%\draw [->] (sumEP) -- node {$E^\ast(s)$} (systemK);
	\draw [->] (sumEP) -- node {} (systemK);
	
	\draw [->] (systemK) -- node {} (systemZOH);
	\draw [->] (systemZOH) -- node {} (system);
	%\draw [->] (sumEP) -- node {$M^\ast(s)$} (systemH);
	% \draw [->] (system) --  (system2);
	\draw [-] (system) --  (branchPoint);
	\draw [->] (branchPoint) -- node (y) {$C(s)$}(output);

	\draw [-] (y) |- (m) {} ;
	\draw [->] (m) -| (sum); %{$-$}  node [near end] {} (sum);
	%\node [below = 0.005 cm of system] (PointHeader) {\scriptsize{$G(s)$}};
	\draw[thick,dotted]     ($(systemZOH.north west)+(-0.25,0.15)$) rectangle ($(system.south east)+(0.25,-0.15)$);
	\draw [brace,decoration={raise=2ex}] (systemZOH.south west) -- node [position label,yshift=-2ex] {$G(s)$} (system.south east);
	\end{tikzpicture}
%\end{figure}
\end{document}
```
![ControlSystems/CSII](ControlSystems/CSII/digraphs.png?raw=true "digraphs")

```tex
\documentclass{article}
\nonstopmode 
\usepackage{adigraph}
\begin{document}
\NewAdigraph{myAdigraph}{
s:0,0;
 1:2,2;
3:2,-2;
2:6,2;
 4:6,-2;
t:8,0;
}{
s,1:25;
s,3:25;
3,4:25;
1,2:35;
 2,t:20;
4,t:30;
3,1:10;
 4,2:10;
 2,3:15::near start;
 4,1:5::near start;
 }
\myAdigraph{
 s,3,4,2,t;
 }
\end{document}
```
![ControlSystems/CSII](ControlSystems/CSII/OgataB6-17.png?raw=true "OgataB6-17")

```tex

\documentclass[%
% border=1pt
border={-25pt 0pt 0pt 0pt} % left bottom right top
]{standalone}
\usepackage{tikz}
\usepackage{amsmath}
\usetikzlibrary{positioning}
\usetikzlibrary{shapes,arrows,calc} 
\usetikzlibrary{decorations.text}
\usetikzlibrary{decorations.pathreplacing}
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
	%\tikzstyle{block} = [draw, fill=blue!20, rectangle, minimum height=3em, minimum width=4em]
	\tikzstyle{block} = [draw, rectangle, minimum height=2em, minimum width=0.5em]
	\tikzstyle{controller} = [draw, fill=red!20, rectangle, minimum height=2em, minimum width=1em]
	\tikzstyle{sum} = [draw, fill=blue!20, circle, node distance=1cm]
	\tikzstyle{input} = [coordinate]
	\tikzstyle{output} = [coordinate]
	\tikzstyle{sampleSP} = [coordinate]
	\tikzstyle{sampleEP} = [coordinate]
	\tikzstyle{otherPoint} = [coordinate]
	\tikzset{
		position label/.style={
			below = 3pt,
			text height = 1.5ex,
			text depth = 1ex
		},
		brace/.style={
			decoration={brace, mirror},
			decorate
		}
	}
	\begin{tikzpicture}[auto, >=latex']
	
	%% Integral Controller
	% Nodes and Blocks
	\node [input] (input) {};
	%\node [sum, right = 1cm of input] (sum) {};
	\node[draw,circle,add={--}{+}{}{},right of= input](sum){}; 
	\node[draw,circle,add={+}{+}{}{},right of= sum](sumint){}; 
	\node [block, right = 1cm of sumint,text width=0.75cm,align=center] (delay1) {$z^{-1}$};
	
	% feedback points
	\node [otherPoint,right = 1.125 cm of delay1] (vkbelow) {}; %{$\frac{1}{Ts+1}$};
	\node [otherPoint, below = 1cm of delay1] (m1) {};
	
	% Gain Blocks
	\node [block, right = 2.25cm of delay1,text width=0.75cm,align=center] (gainK1) {$K_1$};
	
	% Declarations for integral controller
	\draw[thick,dotted]     ($(sumint.north west)+(-0.25,0.45)$) rectangle ($(gainK1.south east)+(0.25,-1.5)$);
	\node [below right=1.5cm and -0.85cm of delay1] {\scriptsize{Integral Controller}}; (text1) 
	%\draw [brace,decoration={raise=2ex}] (sumint.south west) -- node [position label,yshift=-3ex] {$G(s)$} (gainK1.south east);
	
	%% Plant
	\node [otherPoint, right = 0.25cm of gainK1] (sumP1Space) {};
	% Summers
	\node [draw,circle,add={--}{+}{}{}, right of= sumP1Space] (sumP1) {};
	\node [draw,circle,add={+}{+}{}{}, right of= sumP1] (sumP2) {};
	% Blocks
	\node [block, right = 1cm of sumP2,text width=0.75cm,align=center] (delay2) {$z^{-1}$};
	\node [block, below = 1cm of delay2,text width=0.75cm,align=center] (constant05) {$0.5$};
	\node [block, below = 1cm of constant05,text width=0.75cm,align=center] (gainK2) {$K_2$};

	%Output Points
	\node [otherPoint, right = 1cm of delay2] (xk) {};
	
	\node [otherPoint, right = 1.5cm of xk] (yk) {};
	\node [output, right of = yk] (output) {};%{$y(k)$};
	
	\node [output, below = 0.75cm of gainK2] (m2) {};
	
	% Declarations for plant controller
	\draw[thick,dotted]     ($(sumP1.north west)+(-0.25,0.45)$) rectangle ($(xk.south east)+(0.55,-3.95)$);
	\node [below left=0.15cm and 0.001cm of gainK2] {\scriptsize{Plant}}; (text2) 
	
	% Arrows for Integral Controller
	\draw [draw,->] (input) -- node {$r(k)$} (sum);
	\draw [draw,->] (sum) -- node {} (sumint);
	\draw [draw,->] (delay1) -- node {$v(k)$} (gainK1);
	\draw [draw,->] (sumint) -- node {} (delay1);

	% Feedback for integral controller
	\draw [-] (vkbelow) |- (m1) {} ;
	\draw [-] (m1) -| (sumint) {} ;
	
		
	% Arrows for Plant
	\draw [draw,->] (gainK1) -- node {} (sumP1);
	
	\draw [draw,->] (sumP1) -- node[above=0.15] {$u(k)$} (sumP2);
	\draw [draw,->] (sumP2) -- node {} (delay2);
	
	%Feedback to Summers in Plant
	\draw [->] (constant05) -| (sumP2) {} ;
	\draw [->] (gainK2) -| (sumP1) {} ;
	
	% Feedback for plant and finishing up connections
	\draw [->] (xk) |- (constant05) {} ;
	\draw [->] (xk) |- (gainK2) {} ;
	\draw [draw,-] (delay2) -- node {$x_k$} (yk);
	\draw [draw,->] (yk) -- node {$y_k$} (output);
	\draw [-] (yk) |- (m2) {} ;
	\draw [->] (m2) -| (sum) {} ;

	\end{tikzpicture}
%\end{figure}
\end{document}
```
![ControlSystems/CSII](ControlSystems/CSII/pf.png?raw=true "pf")

```tex
\documentclass[11pt]{article}
\pagestyle{empty}
\begin{document}

\begin{center}

\large{\bf MATH0003 Integration \& Differential Equations}
\normalsize

\bigskip

{\bf Partial Fractions} (Anton section 9.5)

\end{center}

\medskip
\noindent
{\bf Definition:} a {\em rational function} 
is a function of the form $P(x)/Q(x)$, 
where $P$ and $Q$ are polynomials.  
A {\em proper} rational function is a rational function 
with the degree of $P$ less than the degree of $Q$.  

\medskip
\noindent
Proper rational functions are usually integrated 
by splitting them up into {\em partial fractions}.  

\medskip
\noindent
{\bf Theorem (partial fractions):} every proper rational function 
may be expressed in the form
\[
\frac{P(x)}{Q(x)} = F_1(x) + F_2(x) + \cdots + F_n(x),
\]
where the $F_i(x)$ are rational functions of the form 
\[
\frac{A}{(ax+b)^k} \;\; {\rm or} \;\; \frac{Ax+B}{(ax^2+bx+c)^k}, 
\]
in which the denominators are factors of $Q$.  
The sum is called the partial fraction decomposition of $P(x)/Q(x)$, 
and the $F_i(x)$ are called partial fractions.  

\medskip
\noindent
Q1. How do we find the {\em form} of the partial fraction decomposition?  

\noindent
Q2. How do we determine the coefficients?  

\medskip
\noindent
{\bf Linear Factor Rule.}  
For each factor of $Q$ of the form $(ax+b)^m$, 
the partial fraction decomposition contains 
the following sum of $m$ partial fractions:  
\[
\frac{A_1}{ax+b} + \frac{A_2}{(ax+b)^2} + \cdots + \frac{A_m}{(ax+b)^m},
\]
where the $A_i$ are constants to be determined.  

\medskip
\noindent
{\bf Quadratic Factor Rule.}  
For each factor of $Q$ of the form $(ax^2+bx+c)^m$, 
where $ax^2+bx+c$ is an irreducible quadratic, 
the partial fraction decomposition contains 
the following sum of $m$ partial fractions:  
\[
\frac{A_1x+B_1}{ax^2+bx+c} + \frac{A_2x+B_2}{(ax^2+bx+c)^2} + \cdots 
  + \frac{A_mx+B_m}{(ax^2+bx+c)^m},
\]
where the $A_i$ and $B_i$ are constants to be determined.  
 
\end{document}

```
![ControlSystems/CSII](ControlSystems/CSII/polesZeroes.png?raw=true "polesZeroes")

```tex
\documentclass{standalone}
\usepackage{tikz}
\usetikzlibrary{shapes.misc}
\begin{document}
\begin{tikzpicture}[scale=2.5, every node/.style={scale=0.6}]

% Axes:
\draw [-latex] (-0.815,0) -- (1.25,0) node [above left]  {$\Re$};
\draw [-latex] (0,-0.15) -- (0,0.6) node [below right] {$\Im$};

% Poles and ticks
\node[cross out,draw=black] at (0.8187,0) {};
\node[] at (0.8187,-0.1) {$\tiny{0.8187}$};
\node[cross out,draw=black] at (0.3679,0) {};
\node[] at (0.3679,-0.1) {$\tiny{0.3679}$};
\node[cross out,draw=black] at (1,0) {};
\node[] at (1,-0.1) {$\tiny{1}$};
% Zeroes and ticks
\node[solid, circle,draw=black] at (-0.6714,0) {};
\node[] at (-0.6714,-0.1) {$\tiny{-0.6714}$};

%% Draw connection arrows
\draw[] (0,0) node[pos=0.8, above left] {}(36:0.6958) node[solid,thick, cross out,draw=black] {};
\node[] at (36:0.6958+0.14) {$\tiny{z=0.6958e^{j36^\circ}}$};
\draw[dashed]  (36:0.6958) -- (-0.6714,0) node[] {};
\draw[dashed]  (36:0.6958) -- (0.3679,0) node[] {};
\draw[dashed]  (36:0.6958) -- (0.8187,0) node[] {};
\draw[dashed]  (36:0.6958) -- (1,0) node[] {};

%% Draw angles for zeroes
\draw (-0.3,0.025)node[] {$\scriptstyle 18.3316^o$};
\draw[red, -stealth] (-0.1,0) arc (0:45:0.25);
%% Draw angles for poles
\draw (0.2,0.025)node[] {$\scriptstyle 122.028^o$};
\draw[red, -stealth] (0.05,0) arc (180:45:0.225);

\draw (0.6,0.025)node[] {$\scriptstyle 64.5096^o$};
\draw[red, -stealth] (0.45,0) arc (180:115.4904:0.325);

\draw (1.1,0.2)node[] {$\scriptstyle 136.9069^o$};
\draw[red, -stealth] (1.15,0) arc (0:136.9069:0.15);
%\draw[red, -stealth] (0,2) arc (90:145:2);
%\draw[dashed] (0,0) -- node[pos=0.8, above right] {$\omega_z$}(125:3.5) node[solid, fill=white, circle,draw=black] {};
%\draw[dashed] (0,0) -- node[pos=0.8, above right] {$\omega_z$}(125:3.5) node[solid, cross out,draw=black] {};
%\draw[dashed] (0,0) -- (125:3.5) node[solid, cross out,draw=black] {};
%\draw[black, -stealth] (1.75,0) node[pos=0.1,above right] {$\theta=120^o$} arc (0:125:1.75);
%
%%\draw[dashed]  (-5,0) node[below left] {$-\xi_p\omega_p$} --  (-5,-3) node[solid, cross out,draw=black] {};
%%\draw[dashed]  (-2,0) node[below left] {$-\xi_z\omega_z$} --  (-2,-3) node[solid, fill=white, circle,draw=black] {};
%%\draw[dashed]  (-2,0) node[below left] {$-\xi$} -- (-2,2.85);
%%\draw[dashed]  (0,2.85) node[below left] {$\omega_n$} -- (-2,2.85);
%\draw[dashed]  (-2,0) node[below left] {$-2$} -- (-2,2.867);
%\draw[dashed]  (0,2.867) node[below left] {$j2\sqrt{(3)}$} -- (-2,2.867);
%\draw[dashed]  (125:3.5) -- (-4,0) node[solid, cross out,draw=black] {};
%\draw (-4,0) node [below left] {-4};
%\draw[black, -stealth] (-2,2)  arc (0:-180:0.3);
%\draw (-3,2.25)node[] {$\theta=30^o$};
\end{tikzpicture}


\end{document}

```
![ControlSystems/CSII](ControlSystems/CSII/sampleEND.png?raw=true "sampleEND")

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
	\node [block, right = 1 cm of sumEP] (systemK) {$K$};
	%\node [block, right = 1 cm of systemK] (system2) {$\frac{1-e^{-s}}{s}$};
	%\node [controller, right = 1 cm of systemK] (system3) {$\frac{1}{s+1}$};
	\node [controller, right = 1 cm of systemK] (systemEND) {$G(z)$};
	\node [otherPoint,right = 1 cm of systemEND] (branchPoint) {};
	\node [otherPoint,below = 1 cm of systemEND] (belowsystem) {}; %{$\frac{1}{Ts+1}$};
	%\node [block, right = 1cm of system] (system2) {$\frac{1}{Ts+1}$};
	\node [output, right = 2cm of branchPoint] (outputY) {};
	\node [input, below = 0.5cm of systemEND] (m) {};
%	\node [block, right = 0.75 of belowsystem] (systemH) {$H_1(s)$};
	
	% Second Sampler Point
%	\node [sampleSP, left = 1cm of systemH] (sysHSP2) {};
%	\node [sampleEP, left = 1cm of sysHSP2] (sysHEP2) {};
%	\node [sampleEP, above = 1cm of sysHEP2] (sumEPTOP2) {};
	
	% Second block 
%	\node [block, left = 1.5cm of sysHEP2] (systemH2) {$H_2(s)$};
%	% Arrows
	\draw [draw,->] (input) -- node {$r(t)$} (sum);
%	% Arrows for first sampler
	\draw [-] (sum) -- node {$e(t)$} (sumSP);
	\draw [-,thick] (sumEPTOP) -- node {$\delta_\tau$} (sumSP);
	% Arrows for block diagrams
	\draw [->] (sumEP) -- node {} (systemK);
	\draw [->] (systemK) -- node {} (systemEND);
	%\draw [->] (system2) -- node {} (systemEND);
	%\draw [->] (system3) -- node {} (systemEND);
%	%Arrows for second sampler (bottom)
%	\draw [-]  (sysHSP2)-- node {$M(s)$} (systemH);  
%	\draw [-,thick] (sysHSP2) -- node {$\delta_\tau$} (sumEPTOP2);
%	%\draw [->] (sumEP) -- node {$M^\ast(s)$} (systemH);
%	% \draw [->] (system) --  (system2);
	% G(s) to branchpoint
	\draw [-] (systemEND) --  (branchPoint);
	\draw [->] (branchPoint) -- node (y) {$C(s)$}(outputY);
	%\draw [-] (outputY) |- (system) {};
	\draw [-] (branchPoint) |- (m) {} ;
%	\draw [<-] (systemH2) -- node {$M^\ast(s)$} (sysHEP2);
%	\draw [->] (systemH2) -| (sum); %{$-$}  node [near end] {} (sum);
	\draw [->] (m) -| node[pos=0.99] {} node [near end] {} (sum); %{$-$}  node [near end] {} (sum);
	\end{tikzpicture}
%\end{figure}
\end{document}
```
![ControlSystems/CSII](ControlSystems/CSII/sampler413.png?raw=true "sampler413")

```tex

\documentclass[%
% border=1pt
border={-25pt 0pt 0pt 0pt} % left bottom right top
]{standalone}
\usepackage{tikz}
\usepackage{amsmath}
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
	\node [block, right = 1cm of sumEP] (systemK) {$K$};
	\node [block, right = 1cm of systemK] (systemZOH) {$\cfrac{1-e^{-s}}{s}$};
	\node [controller, right = 1cm of systemZOH] (system) {$\cfrac{1}{s(s+1)}$};
	\node [otherPoint,right = 1cm of system] (branchPoint) {};
	\node [otherPoint,below = 1 cm of system] (belowsystem) {}; %{$\frac{1}{Ts+1}$};
	%\node [block, right = 1cm of system] (system2) {$\frac{1}{Ts+1}$};
	\node [output, right = 1cm of branchPoint] (output) {};
	\node [input, below = 0.5cm of system] (m) {};

	% Arrows
	\draw [draw,->] (input) -- node {$R$} (sum);
	% Arrows for first sampler
	\draw [-] (sum) -- node {$E(s)$} (sumSP);
	\draw [-,thick] (sumEPTOP) -- node {$\delta_\tau$} (sumSP);
	\draw [->] (sumEP) -- node {$E^\ast(s)$} (systemK);
	\draw [->] (systemK) -- node {} (systemZOH);
	\draw [->] (systemZOH) -- node {} (system);
	%\draw [->] (sumEP) -- node {$M^\ast(s)$} (systemH);
	% \draw [->] (system) --  (system2);
	\draw [-] (system) --  (branchPoint);
	\draw [->] (branchPoint) -- node (y) {$C(s)$}(output);

	\draw [-] (y) |- (m) {} ;
	\draw [->] (m) -| (sum); %{$-$}  node [near end] {} (sum);
	\end{tikzpicture}
%\end{figure}
\end{document}
```
![ControlSystems/CSII](ControlSystems/CSII/samplerBlock.png?raw=true "samplerBlock")

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
	\node [block, right = 2cm of sum] (system) {$\cfrac{K}{s+1}$}; % node[label=below:$b_1$,draw]{};
	\node [below = 0.005 cm of system] (PointHeader) {\scriptsize{$G(s)$}};
	\node [otherPoint,right = 1cm of system] (branchPoint) {};
	\node [otherPoint,below = 1 cm of system] (belowsystem) {}; %{$\frac{1}{Ts+1}$};
	%\node [block, right = 1cm of system] (system2) {$\frac{1}{Ts+1}$};
	\node [output, right = 2cm of branchPoint] (output) {};
	%\node [input, below = 0.5cm of system] (m) {};
	\node [otherPoint, right = 1.25 of belowsystem] (systemRightDownP) {$H_1(s)$};
	
	% Second Sampler Point
	\node [sampleSP, below = 0.5cm of systemRightDownP] (sysHSP2) {};
	\node [sampleEP, left = 1cm of sysHSP2] (sysHEP2) {};
	\node [sampleEP, above = 1cm of sysHEP2] (sumEPTOP2) {};
	
	% Second block 
	\node [block, left = 0.75cm of sysHEP2] (systemH2) {$\cfrac{1-e^{-Ts}}{s}$};
	% Arrows
	\draw [draw,->] (input) -- node {$R$} (sum);
	% Arrows for first sampler
%	\draw [-] (sum) -- node {$E(s)$} (sumSP);
%	\draw [-,thick] (sumEPTOP) -- node {$\delta_\tau$} (sumSP);
	\draw [->] (sum) -- node {$E(s)$} (system);
	%Arrows for second sampler (bottom)
%	\draw [-]  (sysHSP2)-- node {$M(s)$} (systemH);  
	\draw [-,thick] (sysHSP2) -- node {$\delta_\tau$} (sumEPTOP2);
	%\draw [->] (sumEP) -- node {$M^\ast(s)$} (systemH);
	% \draw [->] (system) --  (system2);
	\draw [-] (system) --  (branchPoint);
	\draw [->] (branchPoint) -- node (y) {$C(s)$}(output);
	\draw [-] (y) |- (sysHSP2) {};
	%\draw [-] (y) |- (m) {} ;
	%\draw [<-] (systemH2) -- node {$M^\ast(s)$} (sysHEP2);
	\draw [->] (sysHEP2) -- (systemH2);
	\draw [->] (systemH2) -| node [near end] {$B(s)$} (sum) ; %{$-$}  node [near end] {} (sum);
	%\node [otherPoint, below = 1.25cm of sum] (Text) {$B(s)$};
	%\draw [->] (m) -| node[pos=0.99] {} node [near end] {} (sum); %{$-$}  node [near end] {} (sum);
	\end{tikzpicture}
%\end{figure}
\end{document}
```
![ControlSystems/CSII](ControlSystems/CSII/samplerTesting.png?raw=true "samplerTesting")

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
	\node [block, right = 1 cm of sumEP] (systemK) {$K$};
	\node [block, right = 0.5 cm of systemK] (system2) {$\frac{1-e^{-s}}{s}$};
	\node [controller, right = 1 cm of system2] (system3) {$\frac{1}{s+1}$};
	\node [controller, right = 0.5 cm of system3] (systemEND) {$\frac{1}{s}$};
	\node [otherPoint,right = 1 cm of systemEND] (branchPoint) {};
	\node [otherPoint,below = 1 cm of systemEND] (belowsystem) {}; %{$\frac{1}{Ts+1}$};
	%\node [block, right = 1cm of system] (system2) {$\frac{1}{Ts+1}$};
	\node [output, right = 2cm of branchPoint] (outputY) {};
	\node [input, below = 0.5cm of systemEND] (m) {};
%	\node [block, right = 0.75 of belowsystem] (systemH) {$H_1(s)$};
	
	% Second Sampler Point
%	\node [sampleSP, left = 1cm of systemH] (sysHSP2) {};
%	\node [sampleEP, left = 1cm of sysHSP2] (sysHEP2) {};
%	\node [sampleEP, above = 1cm of sysHEP2] (sumEPTOP2) {};
	
	% Second block 
%	\node [block, left = 1.5cm of sysHEP2] (systemH2) {$H_2(s)$};
%	% Arrows
	\draw [draw,->] (input) -- node {$r(t)$} (sum);
%	% Arrows for first sampler
	\draw [-] (sum) -- node {$e(t)$} (sumSP);
	\draw [-,thick] (sumEPTOP) -- node {$\delta_\tau$} (sumSP);
	% Arrows for block diagrams
	\draw [->] (sumEP) -- node {} (systemK);
	\draw [->] (systemK) -- node {} (system2);
	\draw [->] (system2) -- node {} (system3);
	\draw [->] (system3) -- node {} (systemEND);
%	%Arrows for second sampler (bottom)
%	\draw [-]  (sysHSP2)-- node {$M(s)$} (systemH);  
%	\draw [-,thick] (sysHSP2) -- node {$\delta_\tau$} (sumEPTOP2);
%	%\draw [->] (sumEP) -- node {$M^\ast(s)$} (systemH);
%	% \draw [->] (system) --  (system2);
	% G(s) to branchpoint
	\draw [-] (systemEND) --  (branchPoint);
	\draw [->] (branchPoint) -- node (y) {$C(s)$}(outputY);
	%\draw [-] (outputY) |- (system) {};
	\draw [-] (branchPoint) |- (m) {} ;
%	\draw [<-] (systemH2) -- node {$M^\ast(s)$} (sysHEP2);
%	\draw [->] (systemH2) -| (sum); %{$-$}  node [near end] {} (sum);
	\draw [->] (m) -| node[pos=0.99] {} node [near end] {} (sum); %{$-$}  node [near end] {} (sum);
	\end{tikzpicture}
%\end{figure}
\end{document}
```
![ControlSystems/CSII](ControlSystems/CSII/stepResponsePlot.png?raw=true "stepResponsePlot")

```tex
\documentclass[border={10pt}]{standalone}
\usepackage{tikz,pgfplots,filecontents,amsmath}
\pgfplotsset{compat=1.5}

\begin{filecontents}{data.dat}
 n   yn 
-1   0
0    6
1    2
2    4
3    4
4    4
5    4
6    4
\end{filecontents}


\begin{document}
\begin{tikzpicture}
\begin{axis}
[%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axis x line=middle,
    axis y line=middle,
    every axis x label={at={(current axis.right of origin)},anchor=north west},
    %every axis y label={at={(current axis.above origin)},anchor= north west},
    every axis plot post/.style={mark options={fill=black}},
    xlabel={$k$},
    ylabel={$\boldsymbol{y[k]}$},
    xtick={0,1, ..., 6},
    xmax=7,
    ymin=0,
    ymax=8,
    yticklabels={
    	$0$,
    	$0$,
    	$0.5a+b$,
    	$1$,
    	$a$
    },
]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\addplot+[ycomb,black,thick] table [x={n}, y={yn}] {data.dat};
%\addplot[mark=*] coordinates {(1,2)} node[pin=45:{}]{} ;
\addplot[] coordinates {(0,5.825)} node[pin=320:{arbitrary points at $x(0)$ and $x(1)$}]{} ;
\end{axis}
\end{tikzpicture}

\end{document}

```
![ControlSystems/CSII](ControlSystems/CSII/StraightLinebasicBlock.png?raw=true "StraightLinebasicBlock")

```tex
\documentclass{standalone}

\usepackage{blox}
\usepackage{tikz}
\usepackage{steinmetz}
\usetikzlibrary{positioning}

\usetikzlibrary{circuits}
\begin{document}

\begin{tikzpicture}
\bXInput{E}
\bXChain[2]{E}%
{Md/IF,fred/$ID\phase{RR}$,head/EXE,Fun/Mem, Games/WB}
\end{tikzpicture}
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
