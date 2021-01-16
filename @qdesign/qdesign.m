classdef qdesign  < handle
    %QDESIGN is a class for QFT Loop Design -- A class that hosts all
    %methods required for SISO QFT loop shaping design
    
    properties
        tpl         % templates (qtpl array)
        nom         % nominal case (qfr)
        spc         % specifications (qspc array)
        bnd         % bounds (struct)
        col         % color for each frequency (rgb array)
    end
    
    methods
        function obj = qdesign(plant,specs)
            %QDESIGN Construct an instance of the QDESIGN class
            %
            %Usage:
            %
            %    obj = QDESIGN(plant,specs)    constract a QDESIGN object
            %    from given qplant and qspc
            %
            %Part of the Open Qsyn toolbox.
            
            obj.tpl = plant.templates;
            obj.nom = plant.nominal;
            obj.spc = specs;
            obj.col = lines(length(obj.tpl)); % preserves color for each freq
            disp(['You now have a QFT loop desgin object. ',...
                'Compute bounds using CBND'])
        end
        function [] = clmag(obj,C,F)
            %CLMAG computes closed loop magnitude response
            %
            %Usage:
            %
            %   CLMAG(DES,C,F)   shows magniatude response for P*C*F/(1+C*P)
            %   with feedback C and pre-filter F.
            %
            %Inputs:
            %
            %   DES     qdesign object
            %
            %   C       feedback compensator given as a openQsyn QFR or QCTRL object,
            %           a Control System Toolbox LTI object, or a constant gain. Default C=1.
            %
            %   F       prefilter in given as a openQsyn QFR or QCTRL object,
            %           a Control System Toolbox LTI object, or a constant gain. Default F=1.
            %
            %   Replaces Qsyn command FDESIGN
            
            if nargin<3, F=[]; end
            if isempty(F), F=1; end
            
            if ~isscalar(C), error('C must be a scalar'); end
            if isnumeric(C)
                if ~isreal(C), error('C must be real'); end
                C = 1i*C; % C is a gain
            end
            if ~isscalar(F), error('F must be a scalar'); end
            if isnumeric(F)
                if ~isreal(F), error('F must be real'); end
                F = 1i*F; % F is a gain
            end
            %if isnumeric(C), C=tf(C); end
            %if isnumeric(F), F=tf(F); end
            
            
            % compute nominal
            %wnom = obj.nom.frequency;
            %Cwnom = squeeze(freqresp(C,wnom)); % in complex plain
            %Fwnom = squeeze(freqresp(F,wnom)); % in complex plain
            %Pnom = n2c(obj.nom.response);
            %Lnom = Cwnom.*Pnom;
            %Tnom = Fwnom.*Lnom./(1+Lnom);
            
            wnom = obj.nom.frequency;
            Pnom = n2c(nicresp(obj.nom,wnom));
            Cwnom = n2c(nicresp(C,wnom));
            Fwnom = n2c(nicresp(F,wnom));
            Lnom = Cwnom.*Pnom;
            Tnom = Fwnom.*Lnom./(1+Lnom);
            qfr_nom = qfr(c2n(Tnom,-180),wnom);
            bodeplot(qfr_nom,'PhaseVisible','off')
            hold on
            
            % compute templates
            Tu = cpop( obj.tpl,C,'comp');
            Tr = cpop( Tu,F,'*');
            
            [mag,~,w] = Tr.bode([]);
            for i = 1 : length(mag)
                mag_min(i) = min(mag(i));
                mag_max(i) = max(mag(i));
            end
            fprintf('mag length = %.3f, w length = %.3f',length(mag'),length(w));
            N = min(length(mag'),length(w));
            scatter(w(1:N),mag_min(1:N),'bo')
            scatter(w(1:N),mag_max(1:N),'bo')
        end
        function varargout = loopnic(obj,C)
            %LOOPNIC plots the open-loop on a Nichols chart
            %
            %Usage:
            %
            %   LOOPNIC(DES,C)   plots the nominal open-loop Nichols for a
            %   given qdesign object DES, and a feedback compensator C
            %
            %   h = LOOPNIC(DES,C)   also outputs a figure handle
            %
            %Inputs:
            %
            %   des     qdesign object with computed bounds
            %
            %   C       feedback compensator given as a openQsyn QFR or QCTRL object,
            %           a Control System Toolbox LTI object, or a constant real gain.
            %
            
            % defaults
            linecolor = 'k';
            %t_color = distinguishable_colors(length(obj.tpl));
            t_color = obj.col;
            hold on
            
            if ~isscalar(C), error('C must be a scalar'); end
            if isnumeric(C)
                if ~isreal(C), error('C must be real'); end
                C = 1i*C; % C is a gain!
            end
            Lnom = unwrap(series(obj.nom,C));
            h = Lnom.show('color',linecolor);
            
            for k=1:length(obj.tpl)
                tk = qfr(obj.tpl(k).template(1),obj.tpl(k).frequency);
                Ltpl = series(tk,C);
                [~,w_i] = min(abs(tk.frequency-Lnom.frequency)); %** fix phase shift issues
                phase_dist = real(Ltpl.response) - real(Lnom.response(w_i));
                n_r = floor((abs(phase_dist)+5)/360)*sign(phase_dist);
                Ltpl.response =  Ltpl.response-n_r*360; %***
                h(end+1) = show(Ltpl,'marker','square',...
                    'markeredgecolor','k','markerfacecolor',t_color(k,:));
                text(real(Ltpl.response),imag(Ltpl.response),...
                    sprintf(' %g',obj.tpl(k).frequency),'clipping','on') % single space added
            end
            
            if nargout==1, varargout{1}=h; end
            
        end
    end
    
    methods(Static)
        bound = makebnd(tpl,specfunc,spec,gphase,gmag)
        Tmax = fiosrs(tpl_nom,tpl,GP,spec,par_nom,par)
        Tmax = fidsrs(tpl_nom,tpl,GP,spec,par_nom,par)
        Tmax = fodsrs(tpl_nom,tpl,GP,spec,par_nom,par)
        Tmax = frsrs(tpl_nom,tpl,GP,spec,par_nom,par)
    end
end

