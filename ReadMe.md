## Latex Diagrams
This repo contains all the diagrams I have generated for my academic career at the University Of Victoria.

### ControlSystems/CSI

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

### ControlSystems/CSII

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

### DSP

![DSP](DSP/a511aCopy.png?raw=true "a511aCopy")

```tex
\documentclass[border={10pt}]{standalone}
\usepackage{tikz,pgfplots,filecontents,amsmath}
\pgfplotsset{compat=1.5}

\begin{filecontents}{data.dat}
 n   yn 
0    1
1    2
2    4
3    6
4    8
5    10
6    12
7    14
8    16
9    0
10   0
\end{filecontents}


\begin{document}
\begin{tikzpicture}
\begin{axis}
[%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axis x line=middle,
    axis y line=middle,
    every axis x label={at={(current axis.right of origin)},anchor=north west},
    every axis y label={at={(current axis.above origin)},anchor= north west},
    every axis plot post/.style={mark options={fill=black}},
    xlabel={$n$},
    ylabel={$\boldsymbol{y[n]}$},
    xtick={0,1, ..., 11},
    xmax=11,
    yticklabels={
    	$a^0$,
    	$a^1$,
    	$a^2$,
    	$a^3$,
    	$a^4$,
    	$a^5$,
    	$a^6$,
    	$a^7$,
    	$a^8$,
    	$a^9$,
    	$a^10$
    },
    ymin=0,
    ymax=20,
]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\addplot+[ycomb,black,thick] table [x={n}, y={yn}] {data.dat};
\end{axis}
\end{tikzpicture}

\end{document}

```

![DSP](DSP/a53_b.png?raw=true "a53_b")

```tex
\documentclass[border={10pt}]{standalone}
\usepackage{tikz,pgfplots,filecontents,amsmath}
\pgfplotsset{compat=1.5}

\begin{filecontents}{data.dat}
 n   yn 
-2   0.0
-1   0.0
 0   1.0
 1   2.0
 2   3.0
 3   4.0
 4   4.0
 5   4.0
 6   4.0 
 7   4.0 
 8   4.0
% 3   0.0 
 %4   0.0 
% 5   0.0
\end{filecontents}


\begin{document}

\begin{tikzpicture}
\begin{axis}
[%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axis x line=middle,
    axis y line=middle,
    every axis x label={at={(current axis.right of origin)},anchor=north west},
    every axis y label={at={(current axis.above origin)},anchor= north west},
    every axis plot post/.style={mark options={fill=black}},
    xlabel={$n$},
    ylabel={$\boldsymbol{y[n]}$},
    xtick={-2,0, ..., 8},
    ymin=0,
    ymax=4,
]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\addplot+[ycomb,black,thick] table [x={n}, y={yn}] {data.dat};
\end{axis}
\end{tikzpicture}

\end{document}

```

![DSP](DSP/a54.png?raw=true "a54")

```tex
\documentclass[border={10pt}]{standalone}
\usepackage{tikz,pgfplots,filecontents,amsmath}
\pgfplotsset{compat=1.5}

\begin{filecontents}{dataX.dat}
 n   xn
 0   1.0 
 1   2.0  
 2   3.0  
 3   2.0  
 4   1.0 
 5   1.0
 6   1.0
 7   1.0
 8   1.0
 9   1.0
 10  1.0
\end{filecontents}

\begin{filecontents}{dataY.dat}
	n   yn
	0   2.0 
	1   1.0  
	2   2.0  
	3   -1.0 
	4   2.0 
	5   3.0
	6   1.0
	7   1.0
	8   1.0
	9   1.0
	10  1.0
\end{filecontents}

\begin{document}

\begin{tikzpicture}
\begin{axis}
[%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axis x line=middle,
    axis y line=middle,
    every axis x label={at={(current axis.right of origin)},anchor=north west},
    every axis y label={at={(current axis.above origin)},anchor= north west},
    every axis plot post/.style={mark options={fill=black}},
    xlabel={$n$},
    ylabel={$\boldsymbol{x[n]}$},
    xtick={0,2,...,10},
    ymin=-1,
    ymax=3,
]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\addplot+[ycomb,black,thick] table [x={n}, y={xn}] {dataX.dat};
\end{axis}
\end{tikzpicture}
\begin{tikzpicture}
\begin{axis}
[%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axis x line=middle,
axis y line=middle,
every axis x label={at={(current axis.right of origin)},anchor=north west},
every axis y label={at={(current axis.above origin)},anchor= north west},
every axis plot post/.style={mark options={fill=black}},
xlabel={$n$},
ylabel={$\boldsymbol{y[n]}$},
xtick={0,2,...,10},
ymin=-1,
ymax=3,
]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\addplot+[ycomb,black,thick] table [x={n}, y={yn}] {dataY.dat};
\end{axis}
\end{tikzpicture}


\end{document}

```

![DSP](DSP/a5a11_a.png?raw=true "a5a11_a")

```tex
\documentclass[border={10pt}]{standalone}
\usepackage{tikz,pgfplots,filecontents,amsmath}
\pgfplotsset{compat=1.5}

\begin{filecontents}{data.dat}
 n   yn 
0    1
1   -1
2	 0
3    3
\end{filecontents}


\begin{document}
\begin{tikzpicture}
\begin{axis}
[%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axis x line=middle,
    axis y line=middle,
    every axis x label={at={(current axis.right of origin)},anchor=north west},
    every axis y label={at={(current axis.above origin)},anchor= north west},
    every axis plot post/.style={mark options={fill=black}},
    xlabel={$n$},
    ylabel={$\boldsymbol{y[n]}$},
    xtick={-1,0,2,3, 4},
    xmax=4,
    ymin=-2,
    ymax=3,
]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\addplot+[ycomb,black,thick] table [x={n}, y={yn}] {data.dat};
\end{axis}
\end{tikzpicture}

\end{document}

```

![DSP](DSP/a5_4c.png?raw=true "a5_4c")

```tex
\documentclass[border={10pt}]{standalone}
\usepackage{tikz,pgfplots,filecontents,amsmath}
\pgfplotsset{compat=1.5}

\begin{filecontents}{data.dat}
 n   hn 
 0   2  
 1   -3  
 2   2.0  
% 3   0.0 
 %4   0.0 
% 5   0.0
\end{filecontents}


\begin{document}

\begin{tikzpicture}
\begin{axis}
[%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axis x line=middle,
    axis y line=middle,
    every axis x label={at={(current axis.right of origin)},anchor=north west},
    every axis y label={at={(current axis.above origin)},anchor= north west},
    every axis plot post/.style={mark options={fill=black}},
    xlabel={$n$},
    ylabel={$\boldsymbol{h[n]}$},
    xtick={-1,0,2,4},
    ymin=-3,
    ymax=3,
]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\addplot+[ycomb,black,thick] table [x={n}, y={hn}] {data.dat};
\end{axis}
\end{tikzpicture}

\end{document}

```

![DSP](DSP/block.png?raw=true "block")

```tex
\documentclass{standalone}
\usepackage{pst-sigsys}	%Not used in the creation of this document
\usepackage{tikz}
\usetikzlibrary{arrows,automata}
\usetikzlibrary{automata,positioning,arrows.meta}
\usetikzlibrary{circuits}
\begin{document}

\tikzset{%
	block/.style    = {draw, thick, rectangle, minimum height = 3em,
		minimum width = 3em},
	mult/.style    = {draw, circle, node distance = 2cm}, % Multipler
	sum/.style      = {draw, circle, node distance = 2cm}, % Adder
	input/.style    = {coordinate}, % Input
	output/.style   = {coordinate} % Output
	label/.style   = {draw=none} % Text label
	
}
\newcommand{\suma}{\Large$+$}
\newcommand{\mult}{\Large$\times$}
\newcommand{\inte}{$\displaystyle \int$}
\newcommand{\derv}{\Huge$\frac{d}{dt}$}

\begin{tikzpicture}[auto, node distance=2cm,thick]
\matrix[column sep = .75cm, row sep = .75cm]
{   & & & & & & &\\
	\node [coordinate](a1){}; & \node [block](A2){$\{b_k\}=\{1,1,1,1\}$}; & 	
	\node [coordinate](a3){}; & & & & &\\
	\node (x){$x[n]$}; & & \node [sum](add1){\suma}; &  &\node [coordinate](b5){}; & \node [block](B6){$\{b_k\}=\{1,-1\}$}; & \node [coordinate](b7){};& \node [coordinate](b8){}; \\
	\node [coordinate](c1){}; & \node [block](C2){$\{b_k\}=\{1,1,1,1\}$}; & \node [coordinate](c3){}; & & & & &\\
	& & & & & & &\\
};
\draw [-] (x) to (a1);
\draw [->] (a1) to (A2);
\draw [-] (A2) to (a3);
\draw [->] (a3) to (add1);
\draw [-] (x) to (c1);
\draw [->] (c1) to (C2);
\draw [-] (C2) to (c3);
\draw [->] (c3) to (add1);
\draw [->] (add1) to (B6);
\draw [->] (B6) to (b7);

%draw S text labels
\node[label,shift={(0,0.75)}] at (A2) {System $S_1$};
\node[label,shift={(0,-0.75)}] at (C2) {System $S_2$};
\node[label,shift={(0,-0.75)}] at (B6) {System $S_3$};
\node[label,shift={(-0.25,0.25)}] at (a3) {$y_1[n]$};
\node[label,shift={(-0.25,-0.25)}] at (c3) {$y_2[n]$};
\node[label,shift={(-0.25,0.25)}] at (b5) {$w[n]$};
\node[label,shift={(-0.25,0)}] at (b8) {$y[n]$};
\end{tikzpicture}

\end{document}

```

![DSP](DSP/c514_c.png?raw=true "c514_c")

```tex
\documentclass[border={10pt}]{standalone}
\usepackage{tikz,pgfplots,filecontents,amsmath}
\pgfplotsset{compat=1.5}

\begin{document}

\begin{tikzpicture}
\begin{axis}
[%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
height=5cm,
width=\textwidth,
    axis x line=middle,
    axis y line= none,
%    ylabel={Signal Spectrum of $x(t)$},
     every axis x label={at={(current axis.left of origin)},anchor=south west},
%    every axis y label={at={(current axis.above origin)},anchor= north west},
    %every axis plot post/.style={mark options={fill=black}},
    % every axis plot/.append style={ultra thick},
   xlabel={$f$},
%    ylabel={$\boldsymbol{x[n]}$},
    xtick={0,1,...,11},
    ymax=150,
    xmax=11,
    xmin=-1,
]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\addplot+[ycomb,black,thick] table [x={n}, y={xn}] {data.dat};
\addplot+[ycomb,black] plot coordinates
{(0,1) (1,2) (2,4) (3,8) (4,16) (5,32) (6,64) (7,128) (8,0) (9,0) (10,0)};
\node[label={{$1$}}] at (axis cs:0.25,1) {};
\node[label={{$a^{1}$}}] at (axis cs:1,2) {};
\node[label={{$a^{2}$}}] at (axis cs:2,3) {};
\node[label={{$a^{3}$}}] at (axis cs:3,6) {};
\node[label={{$a^{4}$}}] at (axis cs:4,10) {};
\node[label={{$a^{5}$}}] at (axis cs:5,30) {};
\node[label={{$a^{6}$}}] at (axis cs:6,60) {};
\node[label={{$a^{7}$}}] at (axis cs:7,110) {};
\node[label={{$0$}}] at (axis cs:8,0) {};
\node[label={{$0$}}] at (axis cs:9,0) {};
\node[label={{$0$}}] at (axis cs:10,0) {};
\end{axis}
\end{tikzpicture}

\end{document}

```

![DSP](DSP/e514_c2.png?raw=true "e514_c2")

```tex
\documentclass[border={10pt}]{standalone}
\usepackage{tikz,pgfplots,filecontents,amsmath}
\pgfplotsset{compat=1.5}

\begin{document}

\begin{tikzpicture}
\begin{axis}
[%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
height=5cm,
width=\textwidth,
    axis x line=middle,
    axis y line= none,
%    ylabel={Signal Spectrum of $x(t)$},
     every axis x label={at={(current axis.left of origin)},anchor=south west},
%    every axis y label={at={(current axis.above origin)},anchor= north west},
    %every axis plot post/.style={mark options={fill=black}},
    % every axis plot/.append style={ultra thick},
   xlabel={$f$},
%    ylabel={$\boldsymbol{x[n]}$},
    xtick={0,1,...,7,9,10,11},
    ymin=-40,
    ymax=10,
    xmax=11,
    xmin=-1,
]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\addplot+[ycomb,black,thick] table [x={n}, y={xn}] {data.dat};
\addplot+[ycomb,black] plot coordinates
{(0,1) (1,0) (2,0) (3,0) (4,0) (5,0) (6,0) (7,0) (8,-32) (9,0) (10,0)};
\node[label={{$1$}}] at (axis cs:0,0) {};
\node[label={{$0$}}] at (axis cs:1,0) {};
\node[label={{$0$}}] at (axis cs:2,0) {};
\node[label={{$0$}}] at (axis cs:3,0) {};
\node[label={{$0$}}] at (axis cs:4,0) {};
\node[label={{$0$}}] at (axis cs:5,0) {};
\node[label={{$0$}}] at (axis cs:6,0) {};
\node[label={{$0$}}] at (axis cs:7,0) {};
\node[label={{$-a^{8}$}}] at (axis cs:8,-45) {};
\node[label={{$0$}}] at (axis cs:9,0) {};
\node[label={{$0$}}] at (axis cs:10,0) {};
\end{axis}
\end{tikzpicture}

\end{document}

```

### ElectroMag

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

### EngineeringSoftwareDesign

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/basicBlock.png?raw=true "basicBlock")

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

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/betterClientServer.png?raw=true "betterClientServer")

```tex
\documentclass[border=3mm]{standalone}
\usepackage{tikz}
\usetikzlibrary{positioning,matrix,shapes.arrows}

\tikzset{
	modulematrix/.style={draw=blue!50!red,rounded corners,matrix of nodes,row sep=1cm,column sep=1cm,nodes={draw=green!70,align=center,font=\sffamily},inner ysep=0.5cm},
	module/.style={rounded corners, align=center, font=\sffamily, thick},
	simple module/.style={module, top color=blue!10, bottom color=blue!35, draw=blue!75, text width=40mm, minimum height=15mm},
	module down arrow/.style={module arrow, shape border rotate=-90},
	module right arrow/.style={module arrow},
	module arrow/.style={single arrow, single arrow head extend=2.5mm, draw=gray!75, inner color=gray!20, outer color=gray!35, thick, shape border uses incircle, anchor=tail,minimum height=0.7cm},
}
\begin{document}
	\begin{tikzpicture}
	\node [simple module] (mA) {Module A};
	\matrix[modulematrix,below=of mA,label={[anchor=south]below:Module B}] (mB) {Description 1 & Description 2 \\};
	\matrix[modulematrix,right=of mB,nodes={text width=5cm,align=center},label={[anchor=north]above:Module C}] (mC) {Description 3 \\ Description 4 \\};
	\matrix[modulematrix,below=of mC,label={[anchor=south]below:Module D}] (mD) {Description 5 & Description 6 \\};
	\node [simple module,below=of mD] (mE) {Module E};
	
	\foreach \n in {mA,mC-1-1,mC,mD}
	\node[module down arrow,below=1mm of \n] {};
	
	\foreach \n in {mB-1-1,mB,mD-1-1}
	\node[module right arrow,right=1mm of \n] {};
	\end{tikzpicture}
\end{document}

```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/bytefieldCENG356A2.png?raw=true "bytefieldCENG356A2")

```tex
\documentclass[border=5pt,convert={density=300,size=1080x800,outext=.png}]{standalone}
\usepackage{bytefield}
\usepackage{graphicx}
\usepackage{graphics}
\usepackage{xcolor}
\usepackage{subcaption}
\begin{document}
%\begin{figure}
%\begin{minipage}{.5\textwidth}
%	\centering
%	%\includegraphics[width=.4\linewidth]{image1}
%	%\captionof{figure}{A figure}
%	%\label{fig:test1}
%	\begin{bytefield}{32}
%		\bitheader{0-31} \\
%		\bitbox{4}{Four} & \bitbox{8}{Eight} &
%		\bitbox{16}{Sixteen} & \bitbox{4}{Four}
%	\end{bytefield}
%\end{minipage}%
%\begin{minipage}{.5\textwidth}
%	\centering
%	%\includegraphics[width=.4\linewidth]{image1}
%	%\captionof{figure}{Another figure}
%	%\label{fig:test2}
%	\begin{bytefield}{32}
%		\bitheader{0-31} \\
%		\bitbox{4}{Four} & \bitbox{8}{Eight} &
%		\bitbox{16}{Sixteen} & \bitbox{4}{Four}
%	\end{bytefield}
%\end{minipage}
%\end{figure}
\definecolor{lightcyan}{rgb}{0.84,1,1}
\definecolor{lightgreen}{rgb}{0.64,1,0.71}
\newcommand{\colorbitbox}[3]{%
	\rlap{\bitbox{#2}{\color{#1}\rule{\width}{\height}}}%
	\bitbox{#2}{#3}}
	\begin{bytefield}[bitwidth=2pt,bitheight=\widthof{~Sign~},
		boxformatting={\centering\small}]{64}
		\bitheader[endianness=big]{63,13,0} \\
		\colorbitbox{lightcyan}{50}{VPN} &
		\colorbitbox{lightgreen}{14}{Page Offset}
	\end{bytefield} \hfill \break \newline

\definecolor{lightsomething}{rgb}{0.84,0.7,0.7}
\definecolor{lightsomething2}{rgb}{0.64,0.5,0.71}
	\begin{bytefield}[bitwidth=2pt,bitheight=\widthof{~Sign~},
	boxformatting={\centering\small}]{40}
	\bitheader[endianness=big]{39,13,0} \\
	\colorbitbox{lightsomething}{26}{FPN} &
	\colorbitbox{lightsomething2}{14}{Frame Offset}
\end{bytefield}

\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/bytefieldTest.png?raw=true "bytefieldTest")

```tex
\documentclass{article}
\usepackage{bytefield}
\usepackage{xcolor}
\usepackage{graphicx}
\begin{document}
\begin{bytefield}{16}
	\bitboxes*{1}{01000010} & \bitbox{4}{src\strut} &
	\bitbox{4}{dest\strut} & \bitbox{4}{const\strut}
\end{bytefield}
\section{More testing}
\begin{bytefield}{16}
	\bitheader{0,7,8,15} \\
	\begin{rightwordgroup}{Header}
		\bitbox{4}{Tag} & \bitbox{12}{Mask} \\
		\bitbox{8}{Source} & \bitbox{8}{Destination}
	\end{rightwordgroup} \\
	\wordbox{3}{Data}
\end{bytefield}
\section{Games}
\medskip
\newcommand{\colorbitbox}[3]{%
	\rlap{\bitbox{#2}{\color{#1}\rule{\width}{\height}}}%
	\bitbox{#2}{#3}}
\definecolor{lightcyan}{rgb}{0.84,1,1}
\definecolor{lightgreen}{rgb}{0.64,1,0.71}
\definecolor{lightred}{rgb}{1,0.7,0.71}
\begin{bytefield}[bitheight=\widthof{~Sign~},
	boxformatting={\centering\small}]{32}
	\bitheader[endianness=big]{31,23,0} \\
	\colorbitbox{lightcyan}{1}{\rotatebox{90}{Sign}} &
	\colorbitbox{lightgreen}{8}{Exponent} &
	\colorbitbox{lightred}{23}{Mantissa}
\end{bytefield}
\section{Games}
\medskip
\begin{bytefield}[bitheight=2.5\baselineskip]{32}
	\bitheader{0,7,8,15,16,23,24,31} \\
	\begin{rightwordgroup}{\parbox{6em}{\raggedright These words were taken
				verbatim from the TCP header definition (RFC~793).}}
\bitbox{4}{Data offset} & \bitbox{6}{Reserved} &
\bitbox{1}{\tiny U\\R\\G} & \bitbox{1}{\tiny A\\C\\K} &
\bitbox{1}{\tiny P\\S\\H} & \bitbox{1}{\tiny R\\S\\T} &
\bitbox{1}{\tiny S\\Y\\N} & \bitbox{1}{\tiny F\\I\\N} &
\bitbox{16}{Window} \\
\bitbox{16}{Checksum} & \bitbox{16}{Urgent pointer}
\end{rightwordgroup} \\
\wordbox[lrt]{1}{Data octets} \\
\skippedwords \\
\wordbox[lrb]{1}{} \\
\begin{leftwordgroup}{\parbox{6em}{\raggedright Note that we can display,
		for example, a misaligned 64-bit value with clever use of the
		optional argument to \texttt{\string\wordbox} and
		\texttt{\string\bitbox}.}}
\bitbox{8}{Source} & \bitbox{8}{Destination} &
\bitbox[lrt]{16}{} \\
\wordbox[lr]{1}{Timestamp} \\
\begin{rightwordgroup}{\parbox{6em}{\raggedright Why two Length fields?
			No particular reason.}}
	\bitbox[lrb]{16}{} & \bitbox{16}{Length}
\end{leftwordgroup} \\
\bitbox{6}{Key} & \bitbox{6}{Value} & \bitbox{4}{Unused} &
\bitbox{16}{Length}
\end{rightwordgroup} \\
\wordbox{1}{Total number of 16-bit data words that follow this
header word, excluding the subsequent checksum-type value} \\
\bitbox{16}{Data~1} & \bitbox{16}{Data~2} \\
\bitbox{16}{Data~3} & \bitbox{16}{Data~4} \\
\bitbox[]{16}{$\vdots$ \\[1ex]} &
\bitbox[]{16}{$\vdots$ \\[1ex]} \\
\bitbox{16}{Data~$N-1$} & \bitbox{16}{Data~$N$} \\
\bitbox{20}{\[ \mbox{A5A5}_{\mbox{\scriptsize H}} \oplus
\left(\sum_{i=1}^N \mbox{Data}_i \right) \bmod 2^{20} \]} &
\bitboxes*{1}{000010 000110} \\
\wordbox{2}{64-bit random number}
\end{bytefield}
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/Circles.png?raw=true "Circles")

```tex
\documentclass{article}
\usepackage{enumitem}
\usepackage[most]{tcolorbox}

\usetikzlibrary{arrows}
\usetikzlibrary{shapes}
\newcommand{\mymk}[1]{%
	\tikz[baseline=(char.base)]\node[anchor=south west, draw,rectangle, rounded corners, inner sep=2pt, minimum size=7mm,
	text height=2mm](char){\ensuremath{#1}} ;}

\newcommand*\circled[1]{\tikz[baseline=(char.base)]{
		\node[shape=circle,draw,inner sep=2pt] (char) {#1};}}
	
\begin{document}
\begin{enumerate}
	\def\labelenumi{(\alph{enumi})}
	\item  \tcbox[enhanced,drop shadow,colback=white]{Multiple users will be able to log on.} 
	\item  \tcbox[enhanced,drop shadow,colback=white]{The program will not have any delays.}
	\item  If the system detects a major issue, it will save state and restart.
	\item  \tcbox[enhanced,drop shadow,colback=white]{The user will be able to modify the location of the program’s save location on their machine.}
	\item  The program will show an error message to the user if they enter an invalid value in any section.
\end{enumerate}
\end{document}

```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/ClassDiagram.png?raw=true "ClassDiagram")

```tex
\documentclass[border=3mm]{standalone}
\usepackage[english]{babel}
\usepackage{tikz-uml}
\newcommand\blank[1]{\rule[-.2ex]{#1}{.4pt}}

\begin{document}
  \begin{tikzpicture}
%\umlclass[type=interface]{InterfaceA}{}{}
%\umlclass[y=-4]{ClassA}{}{}  
%\umlimpl[stereo=realizes, pos stereo=0.5]{ClassA}{InterfaceA}
%
%\umlclass[x=4, type=interface]{InterfaceB}{}{}
%\umlclass[x=4, y=-4]{ClassB}{}{}  
%\umlimpl[]{ClassB}{InterfaceB}
%\node[] at (3,-2) {<<realizes>>}; 
\umlclass[]{Pirates Game}
	{
		WORLD\blank{0.2cm}SIZE : constant\blank{0.2cm}type = {w:1500,h:1000}  \\
		WINDOW\blank{0.2cm}WIDTH  : constant\blank{0.2cm}type = 750	\\
		WINDOW\blank{0.2cm}HEIGHT : constant\blank{0.2cm}type = 500	
	}
	{
		preload() : void \\
		create() : void \\
		GameLoop() : void \\
		CreateShip(string,Number,Number,Number) : Sprite \\
	}

\umlclass[x=-2,y=-8]{Player}
	{
		+ x : Number \\
		+ y : Number \\
		+ rotation : Number \\
		+ health : Number \\
		+ alive : Boolean \\
		+ shot  : Boolean \\
		+ bullets : Number \\
		+ speed\blank{0.2cm}x : Number \\
		+ speed\blank{0.2cm}y : Number \\
	}
	{
		update () : void \\
	}	

\umlclass[x=4,y=-6]{Bullet}
{
	+ x : Number \\
	+ y : Number \\
	+ speed\blank{0.2cm}x : Number \\
	+ speed\blank{0.2cm}y : Number \\
}
{
}	

\umlclass[x=12,y=-5]{Hearts}
{
	+ x : Number \\
	+ y : Number \\
	+ speed\blank{0.2cm}x : Number \\
	+ speed\blank{0.2cm}y : Number \\
}
{}

\umlclass[x=12,y=0]{Mini-ships}
{
	+ x : Number \\
	+ y : Number \\
	+ speed\blank{0.2cm}x : Number \\
	+ speed\blank{0.2cm}y : Number \\
	+ rotationDirection : Number \\
	+ rotation : Number
}
{
}
\umlnote[x=7,y=-10,width=7.5cm]{Player}{Interactions between players and  game objects is controlled by the server and client. Each player \\ updates their own position.}
\umlunicompo[mult1=spawns,arg1=server,mult2=bullets,pos1=0.35,pos2=0.65]{Pirates Game}{Bullet}
\umlunicompo[mult1=spawns,arg1=server,mult2=Hearts,pos1=0.15,pos2=0.85]{Pirates Game}{Hearts}
\umlunicompo[geometry=|-|,arg1=creates, mult1=server,arg2=player,mult2=client,pos1=1.5,pos2=2.6]{Pirates Game}{Player}
\umlassoc[geometry=-|,arg1=player,mult1=shoots,mult2=bullets]{Player}{Bullet}
\umlunicompo[mult1=spawns,arg1=server,mult2=Mini-ships]{Pirates Game}{Mini-ships}
\umlassoc[geometry=|-|,arg1=destroys,pos1=1.75]{Bullet}{Mini-ships}
\umlassoc[geometry=-|,arg1=destroys,pos1=0.35]{Bullet}{Hearts}
\end{tikzpicture} 
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/ClientServer.png?raw=true "ClientServer")

```tex
\documentclass[tikz,border=10pt]{standalone}
\usetikzlibrary{positioning,fit,shapes.arrows,shadows}
\newcounter{module}
\setcounter{module}{0}
\renewcommand*\themodule{\Alph{module}}
\tikzset{%
  module/.style={rounded corners, align=center, font=\sffamily, thick},
  simple module/.style={module, top color=blue!10, bottom color=blue!35, draw=blue!75, text width=40mm, minimum height=15mm, drop shadow},
  square module/.style={module, draw=orange!75!black, minimum height=20mm, text width=20mm},
  long module/.style={module, draw=orange!75!black, minimum height=20mm, text width=50mm},
  combo module/.style={module, draw=blue!75!black},
  simple module/.pic={
    \stepcounter{module}
    \node (module \themodule) [simple module] {};
  },
  module down arrow/.style={module arrow, shape border rotate=-90, yshift=1.25mm},
  module up arrow/.style={module arrow, shape border rotate=90, yshift=-1.25mm},
  module right arrow/.style={module arrow, xshift=-1.25mm},
  module left arrow/.style={module arrow, rotate = -180, xshift=1.25mm},
  module rightup arrow/.style={module arrow,rotate =45, yshift=1.25mm,xshift=1.25mm},
  module rightdown arrow/.style={module arrow,rotate =-45, yshift=-1.25mm,xshift=1.25mm},
  module leftup arrow/.style={module arrow,rotate =135, yshift=1.25mm,xshift=-1.25mm},
  module leftdown arrow/.style={module arrow,rotate =215, yshift=-1.25mm,xshift=-1.25mm},
  pics/horizontal module/.style n args=3{
    code={
      \stepcounter{module}
      \coordinate (c) at (0,0);
      \node [module right arrow] at (c) {};
      \node (module \themodule-1) [square module, left=7.5mm of c] {#1};
      \node (module \themodule-2) [square module, right=7.5mm of c] {#2};
      \node (module \themodule-3) [below=1.5mm of c |- module \themodule-2.south, module] {#3};
      \node (module \themodule) [fit=(module \themodule-1) (module \themodule-2) (module \themodule-3), combo module] {};
    }
  },
  pics/vertical module/.style n args=3{
    code={
      \stepcounter{module}
      \coordinate (c) at (0,0);
      \node [module down arrow] at (c) {};
      \node (module \themodule-1) [long module, above=7.5mm of c] {#1};
      \node (module \themodule-2) [long module, below=7.5mm of c] {#2};
      \node (module \themodule-3) [above=1.5mm of module \themodule-1.north, module] {#3};
      \node (module \themodule) [fit=(module \themodule-1) (module \themodule-2) (module \themodule-3), combo module] {};
    }
  },
  module arrow/.style={single arrow, single arrow head extend=2.5mm, drop shadow, draw=gray!75, inner color=gray!20, outer color=gray!35, thick, shape border uses incircle, text height=1.5mm, text width=2.5mm, anchor=center},
  module doubleArrow/.style={double arrow, double arrow head extend=2.5mm, drop shadow, draw=gray!75, inner color=gray!20, outer color=gray!35, thick, shape border uses incircle, text height=1mm, text width=5mm, anchor=center},
}
\begin{document}
\begin{tikzpicture}
	%% Module A --- client side modules
  \pic {simple module};
  \node[] (node name) at (module A) {\large {\textbf{Client-Side}}};
  \node [module down arrow] at ([yshift=-7.5mm]module A.south) {};
  \node [module up arrow] at ([yshift=7.5mm]module A.north) {};
  \node [module left arrow] at ([xshift=-7.5mm]module A.west) {};
  	%% Module b, below module A
  \pic [below=27.5mm of module A.south] {horizontal module={Collisions with bullets, hearts and ships.}{Update player health and position}{Physics}};
  \node [module rightup arrow] at ([xshift=6.5mm,yshift=20mm]module B.east) {};
  	%% Module c, above module A
  \pic [above=33.5mm of module A.north] {horizontal module={Respond to keyboard and mouse inputs.}{Move player and shoot bullets}{Controls}};
  \node [module rightdown arrow] at ([xshift=6.5mm,yshift=-20mm]module C.east) {};
  	%% Module D, left of module A, removed phaser 
   \pic [left=45mm of module A.west] {vertical module={Load Sprites, Images and Sound from folder specific in server. Create game enviroment and create player for the client}{Play music, remove destroyed objects from client and render sprites. Update healthbar for player and output messages when player is destroyed.}{Game Engine}};
    %% Module E
   \pic [right=20mm of module A.east] {simple module};
   \node[] (node name) at (module E) {\large {\textbf{Socket-io}}};
   \node [module left arrow] at ([xshift=-7.5mm]module E.west) {};
   \node [module right arrow] at ([xshift=8.75mm]module E.east) {};
   
  	%% Module F --- server side modules
    \pic [right=19mm of module E.east] {simple module};
  \node[] (node name) at (module F) {\large {\textbf{Server-Side}}};
  \node [module right arrow] at ([xshift=7.5mm]module F.east) {};
  \node [module up arrow] at ([yshift=7.5mm]module F.north) {};
  \node [module down arrow] at ([yshift=-7.5mm]module F.south) {};
  %% Module G
    \pic [right=45mm of module F.east] {vertical module={Periodically spawn hearts and mini-ships in seperate arrays, generate bullets when user presses shoot button.}{Delete hearts and mini-ships if they go out of bounds or hit by bullet. Delete bullets if out of bounds and output log messages.}{Create Obstacles and bullets}};
   %% Module H
   \pic [above=33.5mm of module F.north] {horizontal module={Logic for when players connect and disconnect or destroyed.}{Update players location and send updates to client}{Manage Players}};
   \node [module leftdown arrow] at ([xshift=-6.5mm,yshift=-22.5mm]module H.west) {};
   %% Module I
   \pic [below=27.5mm of module F.south] {horizontal module={Load Folders (assets, sound, js files)}{Update location of obstacles at set intervals}{Manage Game Assets and Obstacles}};
   \node [module leftup arrow] at ([xshift=-6.5mm,yshift=22.5mm]module I.west) {};
%  \pic [right=42.5mm of module B.east] {vertical module={Description 3}{Description 4}};
%  \node [module down arrow] at ([yshift=-7.5mm]module C.south) {};
%  \pic [below=27.5mm of module C.south] {horizontal module={Description 5}{Description 6}};
%  \node [module down arrow] at ([yshift=-7.5mm]module D.south) {};
%  \pic [below=17.5mm of module D.south] {simple module};
\end{tikzpicture}
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/commandPrompt.png?raw=true "commandPrompt")

```tex
\documentclass{standalone}

\usepackage{xcolor}
\usepackage{listings}


\lstdefinestyle{DOS}
{
    backgroundcolor=\color{black},
    basicstyle=\scriptsize\color{white}\ttfamily
}
\begin{document}
\begin{lstlisting}[style=DOS]
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation. All rights reserved.

C:> node server
listening on port 8000
New player joined with state: { x: 889.8103577555021,
	y: 752.1248414312639,
	angle: 0,
	type: '6',
	health: 100 }
Spawning DriftWood (316.6456740652798,706.8880647171098)
New player joined with state: { x: 849.9970300626003,
	y: 818.0782645328588,
	angle: 0,
	type: '5',
	health: 100 }
Spawning DriftWood (729.4982454697532,698.3670219092813)
Spawning Health Pack (302.4444058918867,648.1832695147405)
Player: [l-CPwPTDumIpyxZJAAAA], hit by bullet 
DriftWood number [0] destroyed by bullet [4]
Bullet [0] destroyed because it went offscreen (1057.767911147365,-15.736576261039652)
Spawning DriftWood (677.7964228519133,198.37306259674156)
Spawning Health Pack (696.4702310426835,208.46569810396736)
Spawning DriftWood (651.8236801243313,27.688863345238822)
Bullet [0] destroyed because it went offscreen (-13.088735950588386,764.9687287294422)
Collision between player[00-i166b_J4WWW3tAAAB], healthPack[0]
Player disconnected with state:  transport close
Player disconnected with state:  transport close
\end{lstlisting}
\end{document}

```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/CPUPicture.png?raw=true "CPUPicture")

```tex
\documentclass[tikz, border=2mm]{standalone}

\usetikzlibrary{positioning,shapes,arrows,backgrounds,external,fit,calc}
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{lmodern}

\tikzset{
    BlockCPU/.style={draw,thick, fill=blue!20, rectangle},
    BlockAltre/.style={draw,thick, fill=blue!35, rectangle},
    Periferic/.style={ellipse, draw, fill=blue!15},
    Registre/.style={rectangle, draw, fill=blue!5},
    RegistreBuit/.style={rectangle, draw, fill=blue!30,minimum width=.9cm, minimum height=3mm, inner sep =0pt, outer sep=0.pt, anchor=south east},
    Bus/.style={fill=blue!50},
    Nom/.style={font=\normalsize\sffamily,text centered, minimum size=1cm, text width=1.5cm}
    }

\begin{document}
\begin{tikzpicture}[font={\sffamily\scriptsize}]

\node[Registre, minimum width=3.9cm, minimum height=3.4cm, anchor=south west, label={above:CPU (Processor)}] (CPU) at (0,0) {};
%\node[Nom,above right, align=left] (CPUnom) at (CPU.north west) {CPU};
\node[BlockCPU, minimum width=2cm, anchor=south west] (IB) at (0.3,0.3) {Bus interface};
\node[RegistreBuit] (Reg1) at ($(IB.north east)+(-2mm,5mm)$) {};
\node[RegistreBuit] (Reg2) at (Reg1.north east) {};
\node[RegistreBuit] (Reg3) at (Reg2.north east) {};
\node[RegistreBuit] (Reg4) at (Reg3.north east) {};
\node[RegistreBuit,label={above:Registers}] (Reg5) at (Reg4.north east) {};
\node[BlockCPU, left=3mm of Reg3] (PC) {PC};
\node[BlockCPU, right=5mm of Reg3, minimum width=1cm, minimum height=2cm] (ALU) {ALU};

\draw let \p1=($(Reg1.south) - (Reg1|-IB.north)$), \n1={veclen(\x1,\y1)} in node[double arrow, Bus, shape border rotate=90,anchor=north, minimum height=\n1-\pgflinewidth,minimum width=1mm, double arrow head extend=.5mm]  at ([yshift=.5\pgflinewidth]Reg1.south) {};

\node[single arrow, Bus, anchor=west, minimum width=2mm, single arrow head extend=.5mm, minimum height=5mm-.5\pgflinewidth] at (Reg4.east) {};

\node[single arrow, Bus, anchor=west, minimum width=2mm, single arrow head extend=.75mm, minimum height=5mm-.5\pgflinewidth, shape border rotate=180] at (Reg2.east) {};

\node[double arrow, Bus,, anchor=west, minimum width=1mm, double arrow head extend=.75mm] (BusS) at (IB.east) {System bus};

\node[Registre,minimum width=12mm,minimum height=8mm, anchor=west] (ES) at (BusS.east) {E/S Bridge};

\node[double arrow, Bus,, anchor=west, minimum width=1mm, double arrow head extend=.75mm] (BusM) at (ES.east) {Memory bus};

\node[Registre,minimum width=12mm,minimum height=8mm, text centered,text width=12mm,anchor=west] (Mem) at (BusM.east) {Main memory};

\node[double arrow, Bus,, anchor=north, minimum height=9cm, minimum width=2mm, double arrow head extend=.75mm,anchor=north] (BusES) at ([yshift=-.3cm]ES.south) {Input/Output bus};

\node[single arrow, Bus,, anchor=north, minimum width=2mm, single arrow head extend=.75mm, minimum height=3mm-.5\pgflinewidth, shape border rotate=90] (BusESP) at (ES.south) {};

\node[single arrow, Bus,, anchor=north, minimum width=2mm, single arrow head extend=.75mm, minimum height=5mm-.5\pgflinewidth, shape border rotate=270] (Per1) at ([shift={(-3.5cm,1mm)}]BusES.south) {};

\node[Periferic,anchor=north] (Ratoli) at (Per1.south) {Mouse};

\node[single arrow, Bus, anchor=north, minimum width=2mm, single arrow head extend=.75mm, minimum height=5mm-.5\pgflinewidth, shape border rotate=270] (Per2) at ([shift={(-1.8cm,1mm)}]BusES.south) {};

\node[Periferic,anchor=north] (Teclat) at (Per2.south) {Keyboard};

\node[single arrow, Bus,, anchor=north, minimum width=2mm, single arrow head extend=.75mm, minimum height=5mm, shape border rotate=270] (Per3) at ([shift={(0cm,1mm)}]BusES.south) {};

\node[Periferic,anchor=north] (Pantalla) at (Per3.south) {Display};

\node[single arrow, Bus,, anchor=north, minimum width=2mm, single arrow head extend=.75mm, minimum height=5mm, shape border rotate=270] (Per4) at ([shift={(1.5cm,1mm)}]BusES.south) {};

\node[Periferic,anchor=north] (Disc) at (Per4.south) {Disc};

\node[single arrow, Bus,, anchor=north, minimum width=2mm, single arrow head extend=.75mm, minimum height=5mm, shape border rotate=270] (Per5) at ([shift={(3.5cm,1mm)}]BusES.south) {};

\node[Periferic,anchor=north] (Xarxa) at (Per5.south) {Network};

\path (Disc) -- node {\dots} (Xarxa);

\end{tikzpicture}
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/DisconnectedFromGame.png?raw=true "DisconnectedFromGame")

```tex
\documentclass{standalone}
\usepackage{tikz}
\usepackage{tikzscale}
\pgfdeclarelayer{background,foreground}
\pgfsetlayers{background,main,foreground}
\usepackage{tikz-uml}
\usepackage[english]{babel}  % load this package so tikz-uml loads, it may be due to my japanesse localle lol.

\begin{document}
\begin{tikzpicture}
	\begin{umlseqdiag}
		\umlactor{Player A}
		%\umlobject{Server}
		\umlmulti{Server}
		\umlactor{Player B}
		
		% Player spawns, no other player on the map
		\begin{umlcall}[op=move-player,return=update-players]{Player A}{Server}
		
		\begin{umlcall}[type=return,op=update-players]{Server}{Player B} 
		\end{umlcall} 
		\end{umlcall}
		
		% Player B shoots a bullet
		\begin{umlcall}[op=shoot-bullet,return=bullets-update]{Player B}{Server}
				\begin{umlcallself}[op=ServerGameLoop]{Server}
		\end{umlcallself}
		\begin{umlcall}[type=return,op=bullets-update]{Server}{Player A} 
		\end{umlcall} 
		\end{umlcall}
		\begin{umlcall}[type=return,op=player-hit]{Server}{Player A} 
		\end{umlcall} 
		
		\begin{umlcall}[op=disconnect,type = synchron]{Player A}{Server}
		\end{umlcall}
		\begin{umlcall}[type=return,op=update-players]{Server}{Player B} 
		\end{umlcall} 
		% Player A Moves
%		\begin{umlcall}[op=move-player,return=update-players]{Player B}{Server}
%		\begin{umlcall}[type=return,op=update-players]{Server}{Player A} 
%		\end{umlcall} 
%		\end{umlcall}
		
		%% Game Loop
%		\begin{umlfragment}[type=loop]
%		\begin{umlcallself}[dt=5,op=ServerGameLoop]{Server}
%		\begin{umlcallself}[op=spawnHealthPacks]{Server}
%		\end{umlcallself}
%		% Update hearts, mini-ships on both sides
%		\begin{umlcall}[type=return,op=healthPack-update]{Server}{Player A} 
%		\end{umlcall} 
%		\begin{umlcall}[type=return,op=healthPack-update]{Server}{Player B}
%		\begin{umlcall}[type=return,op=bullet-update]{Server}{Player A} 
%		\end{umlcall}  
%		\begin{umlcall}[type=return,op=bullet-update]{Server}{Player B} 
%		\end{umlcall}  
%		\end{umlcall} 
%				\end{umlcallself}
%		\end{umlfragment}
	\end{umlseqdiag}
\end{tikzpicture}


\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/document.png?raw=true "document")

```tex
\documentclass[12pt,a4paper]{standalone}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{tikz}
\begin{document}
	
	\begin{tikzpicture}
	\draw (0,0) -- (13,0);
	\foreach \x in {0,2,4,6,8,12,13}
	\draw (\x cm,3pt) -- (\x cm,-3pt);
	\draw (0,0) node[below=3pt] (a) {$(i)$} node[above=3pt] {};
	\draw (2,0) node[below=3pt] (b) {} node[above=3pt] {$(ii)$};
	\draw (4,0)  node[below=3pt]  {$(iii)$} node[above=3pt] (c) {};
	\draw (6,0) node[below=3pt](d) {} node[above=3pt] {$(iv)$};
	\draw (8,0) node[below=3pt](e) {$(v)$} node[above=3pt] {};
	\draw (12,0) node[above=3pt] (f) {$(vi)$} node[below=3pt] {};
	\draw[latex-latex]
	(e.north) -- (f.north);
	\draw[latex-latex,blue]
	(e.north) to[bend left] (f.north);
	\draw[latex-latex,red]
	(e.north) to[out=60,in=150] (f.north);
	\end{tikzpicture}\qquad
%	\begin{tikzpicture}
%	\draw (0,0) -- (13,0);
%	\foreach \x in {0,2,4,6,8,12,13}
%	\draw (\x cm,3pt) -- (\x cm,-3pt);
%	\draw (0,0) node[below=3pt] (a) {$(i)$} node[above=3pt] {};
%	\draw (2,0) node[below=3pt] (b) {} node[above=3pt] {$(ii)$};
%	\draw (4,0)  node[below=3pt]  {$(iii)$} node[above=3pt] (c) {};
%	\draw (6,0) node[below=3pt](d) {} node[above=3pt] {$(iv)$};
%	\draw (8,0) node[below=3pt](e) {$(v)$} node[above=3pt] {};
%	\draw (12,0) node[above=3pt] (f) {$(vi)$} node[below=3pt] {};
%	\draw[latex-latex]
%	(e.north|-f.north) -- (f.north);
%	\draw[latex-latex,blue]
%	(e.north|-f.north) to[bend left] (f.north);
%	\draw[latex-latex,red]
%	(e.north|-f.north) to[out=60,in=120] (f.north);
%	\end{tikzpicture}
	
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/fileDirectory.png?raw=true "fileDirectory")

```tex
\documentclass[border=10pt,multi,tikz]{standalone}
\usepackage[edges]{forest}
\definecolor{folderbg}{RGB}{124,166,198}
\definecolor{folderbg3}{RGB}{24,206,148}
\definecolor{folderborder}{RGB}{110,144,169}
\def\foldedpaper#1{
	\tikz[scale=#1,line width={#1*1pt}]{
		\def\a{1.41} % relative height
		\def\b{0.2}  % relative height/width of corner
		\def\c{0.1}  % relative margin width (on either side)
		\def\d{0.05} % vertical offset of lines
		\def\N{6}    % number of lines
		\draw         (0,0)
		--  ++(-1,0)
		--  ++(0,\a)
		--  ++(1-\b,0)
		--  ++(\b,-\b)
		-- cycle;
		\foreach \lnum in {1,...,\N}{
			\pgfmathsetmacro\yline{\a-\d-\lnum*\a/(\N+1)}
			\draw (-1+\c,\yline) -- (-\c,\yline);
		}
		\draw[fill=white] (0,\a-\b) -- ++(-\b,0) -- ++ (0,\b);
	}
}
\newlength\Size
\setlength\Size{4pt}
\tikzset{%
	folder/.pic={%
		\filldraw [draw=folderborder, top color=folderbg!50, bottom color=folderbg] (-1.05*\Size,0.2\Size+5pt) rectangle ++(.75*\Size,-0.2\Size-5pt);
		\filldraw [draw=folderborder, top color=folderbg!50, bottom color=folderbg] (-1.15*\Size,-\Size) rectangle (1.15*\Size,\Size);
	},
	file/.pic={%
		\filldraw [draw=folderborder, top color=folderbg!5, bottom color=folderbg!10] (-\Size,.4*\Size+5pt) coordinate (a) |- (\Size,-1.2*\Size) coordinate (b) -- ++(0,1.6*\Size) coordinate (c) -- ++(-5pt,5pt) coordinate (d) -- cycle (d) |- (c) ;
	},
	file2/.pic={%
		\filldraw [draw=folderborder, top color=folderbg3!20, bottom color=folderbg3!50] (-\Size,.4*\Size+5pt) coordinate (a) |- (\Size,-1.2*\Size) coordinate (b) -- ++(0,1.6*\Size) coordinate (c) -- ++(-5pt,5pt) coordinate (d) -- cycle (d) |- (c) ;
	},
	none/.pic={%
	},
}
\forestset{%
	declare autowrapped toks={pic me}{},
	pic dir tree/.style={%
		for tree={%
			folder,
			font=\ttfamily,
			grow'=0,
		},
		before typesetting nodes={%
			for tree={%
				edge label+/.option={pic me},
			},
		},
	},
	pic me set/.code n args=2{%
		\forestset{%
			#1/.style={%
				inner xsep=2\Size,
				pic me={pic {#2}},
			}
		}
	},
	pic me set={directory}{folder},
	pic me set={file}{file},
	pic me set={file2}{file2},
	pic me set={none}{none},
}
\begin{document}
	
	\begin{forest}
		pic dir tree,
		where level=0{}{% folder icons by default; override using file for file icons
			directory,
		},
		[system
		[assets
		[ship.png, file
		]
		[water.png, file
		]
		[cannonball.png, file
		]
		]
		[js
		[client.js,file2
		]
		[healthMeter.js, file
		]
		]
		[package.json, file
		]
		[index.html, file2
		]
		[server.js, file2
		]
		]
	\end{forest}
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/FlowChart.png?raw=true "FlowChart")

```tex
% Diagram of Android activity life cycle
% Author: Pavel Seda 
\documentclass[border=10pt]{standalone}
\usepackage{tikz}
\usetikzlibrary{arrows.meta}
\tikzset{%
	>={Latex[width=2mm,length=2mm]},
	% Specifications for style of nodes:
	base/.style = {rectangle, rounded corners, draw=black,
		minimum width=4cm, minimum height=1cm,
		text centered, font=\sffamily},
	activityStarts/.style = {base, fill=blue!30},
	startstop/.style = {base, fill=red!30},
	activityRuns/.style = {base, fill=green!30},
	process/.style = {base, minimum width=2.5cm, fill=orange!15,
		font=\ttfamily},
}
\begin{document}    
	% Drawing part, node distance is 1.5 cm and every node
	% is prefilled with white background
	\begin{tikzpicture}[node distance=1.5cm,
	every node/.style={fill=white, font=\sffamily}, align=center]
	% Specification of nodes (position, etc.)
	\node (start)             [activityStarts]              {Activity starts};
	\node (onCreateBlock)     [process, below of=start]          {onCreate()};
	\node (onStartBlock)      [process, below of=onCreateBlock]   {onStart()};
	\node (onResumeBlock)     [process, below of=onStartBlock]   {onResume()};
	\node (activityRuns)      [activityRuns, below of=onResumeBlock]
	{Activity is running};
	\node (onPauseBlock)      [process, below of=activityRuns, yshift=-1cm]
	{onPause()};
	\node (onStopBlock)       [process, below of=onPauseBlock, yshift=-1cm]
	{onStop()};
	\node (onDestroyBlock)    [process, below of=onStopBlock, yshift=-1cm] 
	{onDestroy()};
	\node (onRestartBlock)    [process, right of=onStartBlock, xshift=4cm]
	{onRestart()};
	\node (ActivityEnds)      [startstop, left of=activityRuns, xshift=-4cm]
	{Process is killed};
	\node (ActivityDestroyed) [startstop, below of=onDestroyBlock]
	{Activity is shut down};     
	% Specification of lines between nodes specified above
	% with aditional nodes for description 
	\draw[->]             (start) -- (onCreateBlock);
	\draw[->]     (onCreateBlock) -- (onStartBlock);
	\draw[->]      (onStartBlock) -- (onResumeBlock);
	\draw[->]     (onResumeBlock) -- (activityRuns);
	\draw[->]      (activityRuns) -- node[text width=4cm]
	{Another activity comes in
		front of the activity} (onPauseBlock);
	\draw[->]      (onPauseBlock) -- node {The activity is no longer visible}
	(onStopBlock);
	\draw[->]       (onStopBlock) -- node {The activity is shut down by
		user or system} (onDestroyBlock);
	\draw[->]    (onRestartBlock) -- (onStartBlock);
	\draw[->]       (onStopBlock) -| node[yshift=1.25cm, text width=3cm]
	{The activity comes to the foreground}
	(onRestartBlock);
	\draw[->]    (onDestroyBlock) -- (ActivityDestroyed);
	\draw[->]      (onPauseBlock) -| node(priorityXMemory)
	{higher priority $\rightarrow$ more memory}
	(ActivityEnds);
	\draw           (onStopBlock) -| (priorityXMemory);
	\draw[->]     (ActivityEnds)  |- node [yshift=-2cm, text width=3.1cm]
	{User navigates back to the activity}
	(onCreateBlock);
	\draw[->] (onPauseBlock.east) -- ++(2.6,0) -- ++(0,2) -- ++(0,2) --                
	node[xshift=1.2cm,yshift=-1.5cm, text width=2.5cm]
	{The activity comes to the foreground}(onResumeBlock.east);
	\end{tikzpicture}
\end{document}

```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/GanttScheduling.png?raw=true "GanttScheduling")

```tex
\documentclass{standalone}

\usepackage{pgfgantt}
\definecolor{blue}{HTML}{74BBC9}
\definecolor{yellow}{HTML}{F7E967}
\definecolor{green}{HTML}{7CFC00}	% lawn green
\definecolor{red}{HTML}{FF6347}		% tomato 
\begin{document}
%\begin{figure}
\begin{ganttchart}[
		x unit=0.35cm,
		y unit chart=1.4cm,
		canvas/.style={draw=none,fill=none}, % remove canvas borders, etc
		vgrid={*1{draw=black!12}},           % vertical gray lines every unit
		inline,                              % draw bars inline
		group/.style={draw=none,fill=none},  % remove group borders, etc
		bar top shift=0.1,                   % give bar 10% padding top/bottom
		bar height=0.8,                      % bar size 80% of vertical space
		y unit title=0.5cm,                  % crop titles a little smaller
		title/.style={draw=none,fill=none},  % remove title borders, etc
		include title in canvas=false,        % no vertical grid in title
		milestone inline label node/.append style={left=5mm}	% see if I can include milestones
	]{-1}{32}

	\gantttitle{0}{3}
	\gantttitle{4}{4}
	\gantttitle{8}{4}
	\gantttitle{12}{4}
	\gantttitle{16}{4}
	\gantttitle{20}{4}
	\gantttitle{24}{4} 
	\gantttitle{28}{4}
	\gantttitle{32}{4}\\
	
	% Note that 2 units = 4 in the diagram
	\ganttgroup[inline=false]{CPU}{0}{1}
	\ganttbar[bar/.style={fill=red}]{$P_1$4}{0}{3}
	\ganttbar[bar/.style={fill=green}]{$P_2\mid$5}{4}{8}
	\ganttbar[bar/.style={fill=red}]{$P_1\mid$4}{9}{12}
 	\ganttbar[bar/.style={fill=green}]{$P_2\mid$5}{13}{17}	
 	\ganttbar[bar/.style={fill=red}]{$P_1\mid$4}{18}{21}
 	\ganttbar[bar/.style={fill=blue}]{\tiny{$P_3\mid$2}}{22}{23}
 	\ganttbar[bar/.style={fill=white}]{\tiny {IDLE}}{24}{25}
 	\ganttbar[bar/.style={fill=blue}]{\tiny{$P_3\mid$2}}{26}{27}
  	\ganttbar[bar/.style={fill=white}]{\tiny {IDLE}}{28}{29}
	\ganttbar[bar/.style={fill=blue}]{\tiny{$P_3\mid$2}}{30}{31}
 	\\
%	\ganttmilestone{$T_4-16 =8$}{18}

	\ganttgroup[inline=false]{I/O}{0}{1}
	\ganttbar[bar/.style={fill=red}]{\tiny{$P_1\mid$2}}{4}{5}
	\ganttbar[bar/.style={fill=white}]{\tiny{IDLE}}{6}{8}
	\ganttbar[bar/.style={fill=green}]{\tiny{$P_2\mid$2}}{9}{10}
	\ganttbar[bar/.style={fill=white}]{\tiny{IDLE}}{11}{12}
	\ganttbar[bar/.style={fill=red}]{\tiny{$P_1\mid$2}}{13}{14}
	\ganttbar[bar/.style={fill=white}]{\tiny{IDLE}}{15}{23}
	\ganttbar[bar/.style={fill=blue}]{\tiny{$P_3\mid$2}}{24}{25}
	\ganttbar[bar/.style={fill=white}]{\tiny{IDLE}}{26}{27}
	\ganttbar[bar/.style={fill=blue}]{\tiny{$P_3\mid$2}}{28}{29}
	%\ganttbar[bar/.style={fill=blue}]{2}{2}{5}
	%\ganttbar[bar/.style={fill=yellow}]{6}{6}{8}
	%\ganttbar[bar/.style={fill=white}]{IDLE}{25}{29}
%	\ganttgroup[inline=false]{$T_{2,1}$}{0}{1}
%	\ganttbar[bar/.style={fill=blue}]{1}{0}{1}
%	\ganttbar[bar/.style={fill=yellow}]{7}{9}{11} \\
	
%	\ganttgroup[inline=false]{$T_{3,1}$}{0}{1}
%	\ganttbar[bar/.style={fill=yellow}]{4}{0}{2}

\node (a) [fill=blue,draw,anchor=south] at (current bounding box.north){$P_3$};
\node (b) [fill=green,draw,anchor=south] at ([xshift=-30pt]a.south west){$P_2$};
\node (c) [fill=red,draw,anchor=south] at ([xshift=-30pt]b.south west){$P_1$};
\node (legend) [fill=white,draw,anchor=south] at ([xshift=-30pt]c.south west){Legend:};
%\node[fill=purple,draw,anchor=west] at ([yshift=-20pt]d.south west){Box North East};
\end{ganttchart}
%\caption{A flexible job shop schedule}
%\label{fig:schedule}
%\end{figure}

\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/GitWorkFlow.png?raw=true "GitWorkFlow")

```tex
\documentclass[svgnames]{standalone}

\usepackage{tikz}
\usetikzlibrary{calc,fadings,shapes.arrows,shadows,backgrounds, positioning}

\tikzset{bubble/.style={rectangle, draw=gray,rounded corners,fill=#1,align = flush center,minimum height=1cm,minimum width=1.75cm}}

\tikzfading [name=arrowfading, top color=transparent!0, bottom color=transparent!95]
\tikzset{arrowfill/.style={top color=OrangeRed!20, bottom color=Red, general shadow={fill=black, shadow yshift=-0.8ex, path fading=arrowfading}}}
\tikzset{arrowstyle/.style={draw=FireBrick,arrowfill, single arrow,minimum height=#1, single arrow,
single arrow head extend=.4cm,}}

\begin{document}

\begin{tikzpicture}
% Bubbles
\node[bubble=ForestGreen!40] (wd) at (0,0) {working\\directory};
\node[bubble=Gold!40] (sa) at (2.5,0) {staging\\area};
\node[bubble=DodgerBlue!40] (lc) at (5,0) {local repo};
\node[bubble=Tomato!40] (rc) at (8.5,0) {remote repo};

\node[above= 1 cm of rc,font={\bf}]{Remote};
\node[above= 1 cm of sa,font={\bf}]{Local};
% Lines
\foreach \bubble in {wd,sa,lc,rc}
\draw[ultra thick, gray] ($(\bubble.south)-(0,0.25)$)--($(\bubble.south)-(0,9)$);

% Arrows
\node [arrowstyle=2.5cm,xshift=-0.1cm,yshift=-1.5cm] at ($(wd.south)!0.5!(sa.south)$) {git add};
\node [arrowstyle=2.5cm,xshift=-0.1cm,yshift=-2.5cm] at ($(sa.south)!0.5!(lc.south)$) {git commit};
\node [arrowstyle=3.5cm,xshift=-0.1cm,yshift=-3.5cm] at ($(lc.south)!0.5!(rc.south)$) {git push};
\node [arrowstyle=3.5cm,xshift=0.1cm,yshift=-5cm,shape border rotate=180] at ($(rc.south)!0.5!(lc.south)$) {git fetch};
\node [arrowstyle=5cm,xshift=0.1cm,yshift=-6.5cm,shape border rotate=180] at ($(lc.south)!0.5!(wd.south)$) {git checkout};
\node [arrowstyle=5cm,xshift=0.1cm,yshift=-8cm,shape border rotate=180] at ($(lc.south)!0.5!(wd.south)$) {git merge};

% Background
\begin{pgfonlayer}{background}
\fill[gray!10]($(lc.north)!0.5!(rc.north)+(0,0.5)$)rectangle($(lc.south)!0.5!(rc.south)+(4,-9.5)$) ;
\draw[dashed, shorten <=-1.5cm] ($(lc.south)!0.5!(rc.south)$)--($(lc.south)!0.5!(rc.south)-(0,9.5)$);
\end{pgfonlayer}
\end{tikzpicture}


\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/Matching.png?raw=true "Matching")

```tex
\documentclass{article}
\usepackage{tikz}
\usepackage{xparse}
\usetikzlibrary{tikzmark,decorations.pathreplacing,calc,decorations.markings}

\definecolor{colori}{RGB}{166,35,41}
\definecolor{colorii}{RGB}{248,219,162}

\NewDocumentCommand\MyArrow{O{0pt}mmmO{out=150,in=210}}
{%
\begin{tikzpicture}[overlay, remember picture]
  \draw [->,thick,line width=4pt,#4]
    ( $ ({pic cs:#3}|-{pic cs:#2}) + (-#1,1.3ex) $ ) to[#5]  
    ( $ (pic cs:#3) + (-#1,0) $ );
\end{tikzpicture}%
}

\begin{document}

\MyArrow[0.8em]{start1}{end1}{colorii,line width=3pt}[out=90,in=-90]
\MyArrow[1.8em]{start2}{end1}{colori}[out=120,in=250]
\MyArrow[0.4em]{start3}{end3}{colori}[out=240,in=-30]
\begin{itemize}
\item\tikzmark{end1}Processing 
\item\tikzmark{start1}Embedding in paraffin blocks
\item Microtomy
\item\tikzmark{start2}Staining
\item Microscopy 
\item Testing \tikzmark{start3} \hfill Math \tikzmark{end3}
\item
\end{itemize}

\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/MatchingTable.png?raw=true "MatchingTable")

```tex
\documentclass{standalone}
\usepackage{tikz}
\usetikzlibrary{tikzmark}
\usepackage{booktabs}
\usepackage{amssymb}  % For more math
\usepackage{amsmath}
\usepackage{tabularx}

% no hyphens
\tolerance=1
\emergencystretch=\maxdimen
\hyphenpenalty=10000
\hbadness=10000
\begin{document}
%  \begin{tabular}{cc}
%    14\tikzmark{a}  &   78  \\
%    71\tikzmark{b}  &   \tikzmark{c}93  \\
%  \end{tabular} \newline
\newcolumntype{L}{>{\centering \arraybackslash}m{4cm}} 
\begin{tabular}{L L L}
	(a) code-and-fix \tikzmark{a1} & & \tikzmark{a2} (a) assess risks at each step; do most critical
	action first \\ \midrule
	(b) evolutionary/prototyping \tikzmark{b1} & & \tikzmark{b2}(b) build an initial small requirement
	spec, code it, then ``evolve'' the spec and code as
	needed \\ \midrule
	(c) spiral \tikzmark{c1} & & \tikzmark{c2} (c) build initial requirement specs for several releases,
	then design-and-code each in sequence \\ \midrule
	(d) staged delivery \tikzmark{d1} & & (d) standard phases ( \tikzmark{d2}requirements, design, code,
	test) in order \\ \midrule
	(e) waterfall \tikzmark{e1} & & \tikzmark{e2} (e) write some code, debug it, repeat (i.e.
	ad-hoc) 
\end{tabular}
  \begin{tikzpicture}[overlay, remember picture, yshift=.25\baselineskip, shorten >=.5pt, shorten <=.5pt]
   % \draw [->] ({pic cs:a1}) [bend left] to ({pic cs:e2});
    \draw [->] ({pic cs:a1}) -- ({pic cs:e2});
     \draw [->] ({pic cs:c1}) [bend right] to ({pic cs:a2});
    \draw [->] ([yshift=.75pt]{pic cs:e1}) -- ({pic cs:d2});
    \draw [->] ([yshift=.75pt]{pic cs:b1}) -- ({pic cs:b2});
    \draw [->] ([yshift=.75pt]{pic cs:d1}) -- ({pic cs:c2});
  \end{tikzpicture}
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/Queue.png?raw=true "Queue")

```tex

```

### .

![.](./Pictures.png?raw=true "Pictures")

```tex

```

### EngineeringSoftwareDesign

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/SeqDia1.png?raw=true "SeqDia1")

```tex
\documentclass[border=20pt]{standalone} 
\usepackage[english]{babel} 
\usepackage{tikz-uml} 

\begin{document} 
\small\begin{tikzpicture} 
  \begin{umlseqdiag} 
    \umlactor{user} 
    \umlobject{AudioService} 
    \umlobject[]{Settings} 
    \begin{umlcall}[op=handleMessage(),return=1,name=a]{user}{AudioService}
        \begin{umlcall}[op=persistVolume(),return=1]{AudioService}{AudioService}
             \begin{umlcall}[op=putIntForUser(),return=1]{AudioService}{Settings}
                \begin{umlcall}[op=putStringForUser(),return=1]{Settings}{Settings}
                \end{umlcall} 
             \end{umlcall} 
        \end{umlcall} 
    \end{umlcall}
  \end{umlseqdiag} 

\node [below,font=\scriptsize] at (a-op.south) {MSG\_PERSIST\_VOLUME};
\end{tikzpicture} 
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/SeqDiagramReport.png?raw=true "SeqDiagramReport")

```tex
\documentclass{standalone}
\usepackage{tikz}
\usepackage{tikzscale}
\pgfdeclarelayer{background,foreground}
\pgfsetlayers{background,main,foreground}
\usepackage{tikz-uml}
\usepackage[english]{babel}  % load this package so tikz-uml loads, it may be due to my japanesse localle lol.

\begin{document}
\begin{tikzpicture}
	\begin{umlseqdiag}
		\umlactor{Player A}
		\umlobject{Server}
		\umlactor{Player B}
		
		% Player spawns, no other player on the map
		\begin{umlcall}[op=new-player,return=update-players]{Player A}{Server}
		\end{umlcall}
		
		% Player spawns after player A, update both
		\begin{umlcall}[dt=7.5,op=new-player,return=update-players]{Player B}{Server}
		
		\begin{umlcall}[type=return,op=update-players]{Server}{Player A} 
		\end{umlcall} 
		\end{umlcall}
		
		% Player B shoots a bullet
		\begin{umlcall}[op=shoot-bullet,return=bullets-update]{Player B}{Server}
		\begin{umlcall}[type=return,op=bullets-update]{Server}{Player A} 
		\end{umlcall} 
		\end{umlcall}
		
		% Player A Moves
		\begin{umlcall}[op=move-player,return=update-players]{Player B}{Server}
		\begin{umlcall}[type=return,op=update-players]{Server}{Player A} 
		\end{umlcall} 
		\end{umlcall}
		\begin{umlfragment}[type=loop]
		\begin{umlcallself}[dt=5,op=ServerGameLoop]{Server}
		\begin{umlcallself}[op=spawnHealthPacks]{Server}
		\end{umlcallself}
		% Update hearts, mini-ships on both sides
		\begin{umlcall}[type=return,op=healthPack-update]{Server}{Player A} 
		\end{umlcall} 
		\begin{umlcall}[type=return,op=healthPack-update]{Server}{Player B}
		\begin{umlcall}[type=return,op=bullet-update]{Server}{Player A} 
		\end{umlcall}  
		\begin{umlcall}[type=return,op=bullet-update]{Server}{Player B} 
		\end{umlcall}  
		\end{umlcall} 
				\end{umlcallself}
		\end{umlfragment}
	\end{umlseqdiag}
\end{tikzpicture}

\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/SeqGoodExample.png?raw=true "SeqGoodExample")

```tex
\documentclass[border=3mm]{standalone}
\usepackage[english]{babel}
\usepackage{tikz-uml}

\begin{document}

\begin{tikzpicture}
 \tikzumlset{fill object = white, fill call = gray!20} 
\begin{umlseqdiag}
\umlobject[class=B]{b}
\umlobject[class=C]{c}
\umlobject[class=D]{d}


\begin{umlfragment}[type=loop]
\begin{umlcallself}[op=run]{b} 

\begin{umlcall}[op=send, type=asynchron]{b}{c}
    \begin{umlfragment}[type=alt, label=condition, inner xsep=8]
        \begin{umlcall}[op=send, type=synchron, return=send update]{c}{d}
            \begin{umlcallself}[padding=1.5, op=run]{d} 
            \end{umlcallself}
        \end{umlcall}
        \begin{umlcallself}[op=assess update]{c} 
            \begin{umlcall}[op=send update, type=synchron, return=acknowledge]{c}{b}
            \end{umlcall}
            \begin{umlcall}[op=allow continue, padding=-2.5, type=asynchron]{c}{b}
            \end{umlcall}
        \end{umlcallself}
        \umlfpart[default]
        \begin{umlcall}[op=allow continue, type=asynchron]{c}{b}
        \end{umlcall}
    \end{umlfragment}
\end{umlcall}

\end{umlcallself}

\end{umlfragment}
\umlsdnode[dt=1.5]{b}
\umlsdnode[dt=5]{c}
\umlsdnode[dt=32]{d}
\end{umlseqdiag}
\end{tikzpicture}
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/serverClient.png?raw=true "serverClient")

```tex
\documentclass[ border={60pt 0pt 55pt 0pt} 
% left bottom right top] real order is left bottom right top
]{standalone}
\usepackage{float}
\usepackage{tikz}
\usetikzlibrary{positioning, fit, calc, shapes, arrows}
\usepackage[underline=false]{pgf-umlsd}
% message between threads
% Example:
% \bloodymess[delay]{sender}{message content}{receiver}{DIR}{start note}{end note}
\newcommand{\bloodymess}[7][0]{
  \stepcounter{seqlevel}
  \path
  (#2)+(0,-\theseqlevel*\unitfactor-0.7*\unitfactor) node (mess from) {};
  \addtocounter{seqlevel}{#1}
  \path
  (#4)+(0,-\theseqlevel*\unitfactor-0.7*\unitfactor) node (mess to) {};
  \draw[->,>=angle 60] (mess from) -- (mess to) node[midway, above]
  {#3};

  \if R#5
    \node (#3 from) at (mess from) {\llap{#6~}};
    \node (#3 to) at (mess to) {\rlap{~#7}};
  \else\if L#5
         \node (#3 from) at (mess from) {\rlap{~#6}};
         \node (#3 to) at (mess to) {\llap{#7~}};
       \else
         \node (#3 from) at (mess from) {#6};
         \node (#3 to) at (mess to) {#7};
       \fi
  \fi
}
\begin{document}

%\begin{figure}[H]
%    \centering
    \begin{sequencediagram}
        \newinst{c}{Client}
        \newinst[6]{s}{Server}

        \bloodymess[1]{c}{Requesting Access to Server}{s}{R}{Start}{Server receives}
        \bloodymess[1]{s}{Access Granted}{c}{L}{Server responds}{}
        \bloodymess[1]{c}{Acknowledgement}{s}{R}{2nd handshake begins}{Server receives}
        \bloodymess[1]{s}{Send Data and Acknowledge}{c}{L}{}{End}
    \end{sequencediagram}
    %\caption{Client-Server messaging example}
%\end{figure}
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/Tables.png?raw=true "Tables")

```tex
\documentclass{report}
\usepackage[table]{xcolor}
\definecolor{lightblue}{rgb}{0.93,0.95,1.0}

\begin{document}
 \rowcolors{1}{lightgray}{white}   %% <--- here
 \noindent
 \begin{tabular}[!ht]{>{\bfseries}l <{\raggedright}p{10cm}}
      \rowcolor{black!90}\textcolor{white}{Identifier/Name} & \textcolor{white}{\textbf{UC1 - Login}}  \\
      Importance    & 5/5\\
      Difficulty    & 1/5\\
      Actor(s)      & Generalized User\\
      Goal          & To allow the user to access the system.\\
      Preconditions & The user is at the login page. \\
      Summary       & Will validate the users name and password and subsequently give them access to the
      system.\\
      Steps         & 
                      {\begin{tabular}{@{}p{4cm} | p{4cm}@{}}
                          1. User provides username and password. & 2. System directs user to main system page. \\
                      \end{tabular}} \\
      Postcondition & \textbf{Success:} User is logged in. \newline \textbf{Failure:} The system reamins at the login state. \\
  \end{tabular}
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/timeline.png?raw=true "timeline")

```tex
\documentclass[6pt]{standalone}
\usepackage{tikz}
\usetikzlibrary{snakes}
\usepackage{fullpage}

\begin{document}


%
%\begin{figure}
%\caption{Time Line}
%\centering
%\resizebox{\linewidth}{!}{% Resize table to fit within

\begin{tikzpicture}[]
%draw horizontal line
\draw (0,0) -- (41/1.7,0);
%draw vertical lines
\foreach \x in {0, 8, 15, 22, 29, 36, 41}{
   \draw (\x/1.7,3pt) -- (\x/1.7,-3pt);
}
%draw nodes
\draw (0,0) node[text width = 85pt,align=center,below=3pt] {\textbf{Submit Project Proposal}} node[above=3pt] {Nov 17 2017};
\draw (8/1.7,0) node[below=3pt] {Find Game Engine} node[above=3pt] {Nov 20 2017};
\draw (15/1.7,0) node[text width = 100pt,align=center,below=3pt] {Create Server-Client Architecture} node[above=3pt] {Nov 25 2017};
\draw (22/1.7,0) node[text width = 100pt,align=center,below=3pt] {Implement Game Logic} node[above=3pt] {Nov 29 2017};
\draw (29/1.7,0) node[text width = 100pt,align=center,below=3pt] {Add Music and Effects} node[above=3pt] {Dec 1 2017};
\draw (36/1.7,0) node[text width = 100pt,align=center,below=3pt] {\textbf{In Class Demo}} node[above=3pt] {Dec 2 2017};
\draw (41/1.7,0) node[below=3pt] {\textbf{Finish Report}} node[above=3pt] {Dec 12 2017};
\end{tikzpicture}
%}
%\label{fig:time_line}
%\end{figure}
\end{document}
```

![EngineeringSoftwareDesign](EngineeringSoftwareDesign/WBSChart.png?raw=true "WBSChart")

```tex
\documentclass{standalone}
\usepackage{forest}
\usetikzlibrary{arrows.meta,shapes,positioning,shadows,trees}
%
\tikzset{
    basic/.style  = {draw, text width=2cm, drop shadow, font=\sffamily, rectangle},
    root/.style   = {basic, rounded corners=2pt, thin, align=center,
                     fill=green!30},
    onode/.style = {basic, thin, rounded corners=2pt, align=center, fill=green!60,text width=3cm,},
    tnode/.style = {basic, thin, align=left, fill=pink!60, text width=6.5em},
    xnode/.style = {basic, thin, rounded corners=2pt, align=center, fill=blue!20,text width=5cm,},
    wnode/.style = {basic, thin, align=left, fill=pink!10!blue!80!red!10, text width=6.5em},
    edge from parent/.style={draw=black, edge from parent fork right}

}
%
\begin{document}
\begin{forest} for tree={
    grow=east,
    growth parent anchor=east,
    parent anchor=east,
    child anchor=west,
    edge path={\noexpand\path[\forestoption{edge},->, >={latex}] 
         (!u.parent anchor) -- +(5pt,0pt) |- (.child anchor)
         \forestoption{edge label};}
}
[Networked Game Work BreakDown, root
    [Software Engineering Report, xnode
        [Setting shape, tnode]
        [Choosing color, tnode]
        [Adding shading, tnode] ]
    [Game Demo Preparation, onode
        [Using a Matrix, tnode]
        [Relatively, tnode]
        [Absolutely, tnode] 
        [Using overlays, wnode] ]
    [Project Proposal and Game Logic, onode
        [Default arrows, tnode]
        [Arrow library, tnode]
        [Resizing tips, tnode] 
        [Shortening, tnode]
        [Bending, tnode] ] ]
\end{forest}
\end{document}
```

