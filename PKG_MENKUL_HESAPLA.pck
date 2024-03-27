create or replace package PKG_MENKUL_HESAPLA is
  /*
  *  BU PAKET İÇİNDEKİ FONKSİYONLAR AĞIRLIKLA 
  *  BANKA BONOLARI İÇİN KULLANILMAKTADIR.
  *
  */

  type vt_degerler is table of number index by binary_integer;
  type vt_vadeler is table of date index by binary_integer;

  Type Rc_Menkul Is Ref Cursor;

  Procedure TanimliUygunFaiziBul(p_Talep_Edilen_Tutar in number,
                                 p_Vade_gun_sayisi    in number,
                                 p_Doviz_Kodu         in varchar2,
                                 p_menkul_cinsi       varchar2,
                                 p_islem_yonu         varchar2,
                                 p_faiz_orani         out number,
                                 p_marj_sube          out number,
                                 p_marj_gmy           out number);

  function ISINKuponlumu(ps_isin varchar2) return varchar2;
  function ISINDovizCinsi(ps_isin varchar2) return varchar2;
  function OnayBekleyenNominal(pn_portfoy_id number) return number;
  function KullanilabilirNominal(pn_portfoy_id number) return number;
  procedure FiyatTutarIsinHesapla(ps_menkul_cinsi varchar2,
                                  pn_musteri_no   number,
                                  pn_tutar        number,
                                  pd_vade         date,
                                  pn_oran         number,
                                  pn_komisyon     number default 0,
                                  ps_ihrac_sekli  varchar2 default 'T',
                                  ps_doviz        varchar2,
                                  ps_emanetmi     varchar2,
                                  pc_tuzel_bono   varchar2 default 'H',
                                  ----  out lar
                                  pn_portfoy_id          out number,
                                  ps_isin                out varchar2,
                                  pd_isin_vade           out date,
                                  pn_stopaj_orani        out number,
                                  pn_satis_nominal       out number,
                                  pn_satis_tutar         out number,
                                  pn_satis_birim_fiyat   out number,
                                  pn_satis_net_oran      out number,
                                  pn_satis_brut_oran     out number,
                                  pn_donus_net_tutari    out number,
                                  pn_donus_brut_tutari   out number,
                                  pn_donus_net_getiri    out number,
                                  pn_donus_brut_getiri   out number,
                                  pn_donus_stopaj_tutari out number,
                                  pn_donus_birim_fiyati  out number,
                                  ps_depo_turu           out varchar2
                                  
                                  );

  Function XIRR(ptable_degerler       vt_degerler,
                ptable_vadeler        vt_vadeler,
                pn_yil_gun_sayisi     number default 365,
                pn_gun_sayisi_yontemi number default 3) return number;
  Function XNPV(pn_irr_oran           number,
                ptable_degerler       vt_degerler,
                ptable_vadeler        vt_vadeler,
                pn_yil_gun_sayisi     number default 365,
                pn_gun_sayisi_yontemi number default 3) return number;
  Function IRROranHesaplaBB(pn_referans number) return number;
  Function IRRFiyatHesaplaBB(pn_referans    number,
                             pd_rees_tarihi date,
                             pn_irr_oran    number) return number;
  Function FaizGideriBB(pn_referans number, pd_rees_tarihi date)
    return number;

  Procedure BB_Geri_Alis_Hesapla(pn_Talep_Nominal  in number,
                                 pn_Talep_Tutar    in number,
                                 pn_Faiz_Orani     in number,
                                 pn_Satis_referans in number,
                                 --- out
                                 p_Burut_Tutar        out number,
                                 p_Net_Tutar          out number,
                                 p_kalan_nominal      out number,
                                 p_birim_fiyat        out number,
                                 p_stopaj_kesintisi   out number,
                                 p_stopaj_oran        out number,
                                 p_bugunku_degeri     out number,
                                 p_vadesindeki_degeri out number,
                                 p_ga_nominal         out number,
                                 p_isin               out varchar2,
                                 pn_bugunku_fiyat     out number,
                                 pn_faiz_oran         out number,
                                 pn_odenen_net_tutar  out number,
                                 pn_ihrac_farki       out number,
                                 pn_taahhut           out number,
                                 pn_brut_getiri       out number
                                 
                                 );

  Function BugunkuDegerBono(p_referans number) return number;
  Function BugunkuNetDegerBono(p_referans number) return number;
  Function BugunkuFiyatBono(p_referans number) return number;

  function OnaydakiGeriAlisNominal(p_satis_referans number) return number;
  function ISINIhracTarihi(pc_isin varchar2) return date;
  function ISINItfaTarihi(pc_isin varchar2) return date;
  function KuponBaslamaTarihi(pc_isin varchar2, pd_tarih date) return date;
  function YasayanKuponVadesi(pc_isin varchar2, pd_tarih date) return date;
  function KuponGunSayisi(pc_isin varchar2, pd_tarih date) return number;
  function KuponOrani(pc_isin varchar2, pd_tarih date) return number;
  --function BirikmisKuponFaizi(pc_isin varchar2, pd_tarih date) return number;
  function ItfaKuponSayisi(pc_isin         varchar2,
                           pd_tarih        date,
                           pd_satis_tarihi date) return number;
  function KalanKuponSayisi(pc_isin varchar2, pd_tarih date) return number;
  function TemizFiyat(pn_kirli_fiyat          number,
                      pn_birikmis_kupon_faizi number) return number;
  function KuponBasiFazlaOdeme(pn_kirli_fiyat          number,
                               pn_birikmis_kupon_faizi number,
                               pn_kalan_kupon_sayisi   number) return number;
  function ISINVergiyeTabimi(pc_isin varchar2) return char;
  function MusteriVergiyeTabimi(pn_musteri_no number) return char;
  function VergiOrani(pn_musteri_no number,
                      pc_isin       varchar2,
                      pc_emanetmi   varchar2) return number;
  function KuponGeliri(pc_isin         varchar2,
                       pd_kupon_vadesi date,
                       pn_kupon_orani  number,
                       pd_satis_tarihi date,
                       pn_nominal      number,
                       pn_satis_fiyati number) return number;
  function KuponVergiTutariBB(pn_kupon_geliri number,
                              pn_stopaj_orani number) return number;
  function VergiHesaplaBB(pd_tarih          date,
                          pn_satis_referans number,
                          pn_musteri_no     number,
                          pn_nominal        number,
                          pn_fiyat          number) return number;

  function KuponluBonoGeriAlisFiyati(ps_isin         varchar2,
                                     pd_satis_tarih  date,
                                     pd_ga_tarih     date,
                                     pn_satis_fiyati number,
                                     pn_ga_faizi     number) return number;
  function KuponluBonoGeriAlisFiyatiErken(ps_isin         varchar2,
                                          pd_satis_tarih  date,
                                          pd_ga_tarih     date,
                                          pn_satis_fiyati number,
                                          pn_ga_faizi     number,
                                          ps_erkenmi      varchar2)
    return number;

  function BBVergiOrani(pn_musteri_no   number,
                        ps_emanetmi     varchar2,
                        ps_menkul_cinsi varchar2,
                        ps_isin         varchar2,
                        pd_alis_tarihi date,
                        pd_vade date) return number;
  procedure KuponluSatisHesapla(ps_isin         varchar2,
                                pd_satis_tarih  date,
                                pd_vade_tarihi  date,
                                pn_satis_fiyati number,
                                pn_faiz         number,
                                pn_talep_tutar  number,
                                --- out
                                pn_toplam_tutar          out number,
                                pn_birikmisKupon         out number,
                                pn_kirliFiyat            out number,
                                pn_temizFiyat            out number,
                                pn_basitFaiz             out number,
                                pn_bilesikFaiz           out number,
                                pn_vadeyeKalanGun        out number,
                                pn_vadesindeKirliFiyat   out number,
                                pn_vadesindeTemizFiyat   out number,
                                pn_nominal               out number,
                                pn_VadesindeBrutGetiri   out number,
                                pn_VadesindeburutTutar   out number,
                                pn_vadeKadarToplamtTutar out number,
                                pn_kupon_araligi         out number);
  procedure KuponFaizindenFiyatHesapla(ps_isin        varchar2,
                                       pd_satis_tarih date,
                                       pn_faiz        number,
                                       pn_kirli_fiyat out number,
                                       pn_temiz_fiyat out number);
  procedure KuponFiyattanFaizHesapla(ps_isin          varchar2,
                                     pd_satis_tarih   date,
                                     pn_satis_fiyat   number,
                                     pn_referans_faiz number,
                                     pn_satis_oran    out number);
  function KuponluBirikmisKupon(ps_isin varchar2, pd_tarih date)
    return number;

  function YasayanKuponOrani(pc_isin varchar2, pd_tarih date) return number;

  function FiyatHesaplaIskontoluBB(pd_tarih         date,
                                   pn_iskonto_orani number,
                                   pd_isin_vadesi   date) return number;
  function IskontoOraniHesaplaIskontoluBB(pd_tarih       date,
                                          pn_fiyat       number,
                                          pd_isin_vadesi date) return number;

  function GAFiyatHesaplaIskontoluBB(pd_tarih        date,
                                     pn_ga_orani     number,
                                     pd_satis_tarihi date,
                                     pn_satis_fiyati number) return number;

  function GAOranHesaplaIskontoluBB(pd_tarih        date,
                                    pn_ga_fiyati    number,
                                    pd_satis_tarihi date,
                                    pn_satis_fiyati number) return number;

  Procedure BB_Geri_Alis_Hesapla_Fiyattan(pn_Talep_Nominal  in number,
                                          pn_Talep_Tutar    in number,
                                          pn_Faiz_Orani     in number,
                                          pn_Iskonto_Orani  in number,
                                          pn_Fiyat          in number,
                                          pn_Satis_referans in number,
                                          
                                          p_Burut_Tutar        out number,
                                          p_Net_Tutar          out number,
                                          p_kalan_nominal      out number,
                                          p_birim_fiyat        out number,
                                          p_stopaj_kesintisi   out number,
                                          p_stopaj_oran        out number,
                                          p_bugunku_degeri     out number,
                                          p_vadesindeki_degeri out number,
                                          p_ga_nominal         out number,
                                          p_isin               out varchar2,
                                          pn_bugunku_fiyat     out number,
                                          pn_faiz_oran         out number,
                                          pn_odenen_net_tutar  out number,
                                          pn_ihrac_farki       out number,
                                          pn_taahhut           out number,
                                          pn_brut_getiri       out number,
                                          po_Iskonto_Orani     out number,
                                          pd_islem_tarihi      date default trunc(pkg_muhasebe.Banka_Tarihi_Bul)
                                          
                                          );

  function KuponluBonoGeriAlisOraniErken(ps_isin         varchar2,
                                         pd_satis_tarih  date,
                                         pd_ga_tarih     date,
                                         pn_satis_fiyati number,
                                         pn_ga_fiyati    number,
                                         ps_erkenmi      varchar2)
    return number;

  function ISINCinsKodu(pc_isin varchar2) return char;

  Function Urun_Dokuman_Listesi(ps_URUN_KOD varchar2) return Rc_Menkul;
  function TalimatNominal(pn_portfoy_id number) return number;

  function TalimatNominalHist(pd_tarih date, pn_portfoy_id number)
    return number;

  function UygunIsinItfaTarihi(ps_menkul_cinsi varchar2,
                               pn_musteri_no   number,
                               pn_tutar        number,
                               pn_oran         number,
                               pn_komisyon     number default 0,
                               ps_ihrac_sekli  varchar2 default 'T',
                               ps_doviz        varchar2,
                               ps_emanetmi     varchar2,
                               pc_tuzel_bono   varchar2 default 'H')
    return date;

  Function yatirim_fonu_mu(pn_musteri_no number) return varchar2;
  Function BonoMusteriTuru(pn_musteri_no number, pn_referans number)
    return varchar2;
  Function BonoMusteriHesapSube(pn_musteri_no number,
                                pn_hesapno    number,
                                pn_referans   number)
    return muh_hesap.sube_kodu%type;
  Function BonoMusteriYurtIciDisi(pn_musteri_no number, pn_referans number)
    return varchar2;
  function TalimatNominal(pn_musteri_no number, pn_portfoy_id number)
    return number;
  Function GetIstatistikKodu(ps_sahiplik   varchar2,
                             pn_musteri_no number,
                             ps_isin       varchar2,
                             ps_islem_turu varchar2,
                             ps_tutar_faiz varchar2) return varchar2;
  function GetBonoTipi(ps_kupon_tipi varchar2) return varchar2;
  Function GetKuponTipi(ps_bono_tipi varchar2) return varchar2;
  Function BonoMusteriTuruYeni(pn_musteri_no number, pn_referans number)
    return varchar2;
 Function BugunkuDegerDibs(p_isin varchar2,p_nominal number, p_doviz_kodu varchar2, p_tarih date default pkg_muhasebe.Banka_Tarihi_Bul) return number ;
 Function BugunkuNetDegerBono(p_musteri_no number, p_isin varchar2 , p_tarih date default pkg_muhasebe.Banka_Tarihi_Bul) return number;
 
  function getTeminatNominal(pn_bono_hesap_no number) return number;
 
end PKG_MENKUL_HESAPLA;
/
create or replace package body PKG_MENKUL_HESAPLA is

	------------------------------------------------

	Procedure TanimliUygunFaiziBul(p_Talep_Edilen_Tutar in number,
																 p_Vade_gun_sayisi    in number,
																 p_Doviz_Kodu         in varchar2,
																 p_menkul_cinsi       varchar2,
																 p_islem_yonu         varchar2,
																 --        p_kanal_kod number default pkg_global.Get_KanalKod,
																 p_faiz_orani out number,
																 p_marj_sube  out number,
																 p_marj_gmy   out number) is
	
		p_kanal_kod number default pkg_global.Get_KanalKod;
	
	begin
		--- ilk once istenen urunun istenen kanal faizini bul
	
		select fo.min_faiz_orani, fo.marj1, fo.marj2
			into p_faiz_orani, p_marj_sube, p_marj_gmy
			from men_alim_satim_faizleri fo
		 where 1 = 1
			 and p_Vade_gun_sayisi between fo.min_vade and fo.max_vade
			 and p_Talep_Edilen_Tutar between fo.min_tutar and fo.max_tutar
			 and p_Doviz_Kodu = fo.doviz_kodu
			 and fo.menkul_cinsi = p_menkul_cinsi
			 and p_islem_yonu = fo.islem_yonu
			 and fo.silindi = 'H'
			 and fo.kanal = p_kanal_kod;
	
	Exception
		-- yoksa tum kanallar icin olan bul
		when no_data_found then
			begin
				select fo.min_faiz_orani, fo.marj1, fo.marj2
					into p_faiz_orani, p_marj_sube, p_marj_gmy
					from men_alim_satim_faizleri fo
				 where 1 = 1
					 and p_Vade_gun_sayisi between fo.min_vade and fo.max_vade
					 and p_Talep_Edilen_Tutar between fo.min_tutar and fo.max_tutar
					 and p_Doviz_Kodu = fo.doviz_kodu
					 and fo.menkul_cinsi = p_menkul_cinsi
					 and p_islem_yonu = fo.islem_yonu
					 and fo.silindi = 'H'
					 and fo.kanal = -1;
			
			Exception
				-- Genemi yok tum menkuller icin olani o kanal icin bul
				when no_data_found then
					begin
						select fo.min_faiz_orani, fo.marj1, fo.marj2
							into p_faiz_orani, p_marj_sube, p_marj_gmy
							from men_alim_satim_faizleri fo
						 where 1 = 1
							 and p_Vade_gun_sayisi between fo.min_vade and fo.max_vade
							 and p_Talep_Edilen_Tutar between fo.min_tutar and
									 fo.max_tutar
							 and p_Doviz_Kodu = fo.doviz_kodu
							 and fo.menkul_cinsi in
									 (select x.ana_cins_kodu
											from men_menkul_cinsleri x
										 where x.cins_kodu = p_menkul_cinsi)
							 and p_islem_yonu = fo.islem_yonu
							 and fo.silindi = 'H'
							 and fo.kanal = p_kanal_kod;
					Exception
						-- Genemi yok tum menkuller icin tum kanallarda gecerli olani bul
						when no_data_found then
							begin
								select fo.min_faiz_orani, fo.marj1, fo.marj2
									into p_faiz_orani, p_marj_sube, p_marj_gmy
									from men_alim_satim_faizleri fo
								 where 1 = 1
									 and p_Vade_gun_sayisi between fo.min_vade and
											 fo.max_vade
									 and p_Talep_Edilen_Tutar between fo.min_tutar and
											 fo.max_tutar
									 and p_Doviz_Kodu = fo.doviz_kodu
									 and fo.menkul_cinsi in
											 (select x.ana_cins_kodu
													from men_menkul_cinsleri x
												 where x.cins_kodu = p_menkul_cinsi)
									 and p_islem_yonu = fo.islem_yonu
									 and fo.silindi = 'H'
									 and fo.kanal = -1;
							Exception
								when no_data_found then
									p_faiz_orani := 0; -- Ne yapsak bulamadik....
							end;
					end;
			end;
	end;

	--************************************************************---

	function ISINKuponlumu(ps_isin varchar2) return varchar2 is
		vn_count number;
	begin
		select count(*)
			into vn_count
			from men_tanim m
		 where m.isin = ps_isin
			 and m.kuponlu = 'E';
	
		if vn_count = 0 then
			return 'H';
		else
			return 'E';
		end if;
	end;
	--************************************************************---
	function ISINDovizCinsi(ps_isin varchar2) return varchar2 is
		vc_dov varchar(10);
	begin
		select m.doviz_kodu
			into vc_dov
			from men_tanim m
		 where m.isin = ps_isin;
	
		return vc_dov;
	end;

	---***************************************************************----
	function OnayBekleyenNominal(pn_portfoy_id number) return number is
		vn_nom          number;
		ld_banka_tarihi date;
	begin
		ld_banka_tarihi := pkg_muhasebe.Banka_Tarihi_Bul;
	
		select nvl(sum(t.satis_nominal), 0)
			into vn_nom
			from bb_satis_tx t, muh_islem m
		 where t.portfoy_id = pn_portfoy_id
			 and t.satis_tarihi = ld_banka_tarihi
			 and m.kayit_tarih = ld_banka_tarihi
			 and t.tx_no = m.numara
			 and m.durum in ('C', 'V', '1', 'A');
	
		return vn_nom;
	end;
	---****************************************************************--

	function KullanilabilirNominal(pn_portfoy_id number) return number is
		vn_nom number;
	begin
		select nvl(p.kalan_naminal, 0) - nvl(p.rezerv_nominal, 0) -
					 TalimatNominal(p.id)
			into vn_nom
			from men_ihrac_portfoy p
		 where p.id = pn_portfoy_id;
	
		return nvl(vn_nom, 0) - OnayBekleyenNominal(pn_portfoy_id);
	end;
	--******************************************************************--

	procedure FiyatTutarIsinHesapla(ps_menkul_cinsi varchar2,
																	pn_musteri_no   number,
																	pn_tutar        number,
																	pd_vade         date,
																	pn_oran         number,
																	pn_komisyon     number default 0,
																	ps_ihrac_sekli  varchar2 default 'T',
																	ps_doviz        varchar2,
																	ps_emanetmi     varchar2,
																	pc_tuzel_bono   varchar2 default 'H',
																	----  out lar
																	pn_portfoy_id          out number,
																	ps_isin                out varchar2,
																	pd_isin_vade           out date,
																	pn_stopaj_orani        out number,
																	pn_satis_nominal       out number,
																	pn_satis_tutar         out number,
																	pn_satis_birim_fiyat   out number,
																	pn_satis_net_oran      out number,
																	pn_satis_brut_oran     out number,
																	pn_donus_net_tutari    out number,
																	pn_donus_brut_tutari   out number,
																	pn_donus_net_getiri    out number,
																	pn_donus_brut_getiri   out number,
																	pn_donus_stopaj_tutari out number,
																	pn_donus_birim_fiyati  out number,
																	ps_depo_turu           out varchar2
																	
																	) is
		vn_gun_farki    number;
		vn_fiyat        number;
		vn_nominal      number;
		ld_islem_tarihi date;
	
		cursor c is
			select *
				from (select t.cinsi,
										 p.isin,
										 p.id,
										 p.depo_turu,
										 t.vade,
										 pkg_menkul_hesapla.KullanilabilirNominal(p.id) kalan,
										 nvl(t.kupur, 100) kupur,
										 p.kalan_naminal
								from men_tanim t, men_ihrac_portfoy p
							 where t.isin = p.isin
								 and trunc(t.vade) >= trunc(pd_vade)
								 and t.doviz_kodu = ps_doviz
								 and pkg_menkul_hesapla.KullanilabilirNominal(p.id) > 0
								 and (ps_doviz = 'TRY' or
										 pkg_musteri.yurt_ici_disi(pn_musteri_no) = 'D' or
										 p.depo_turu = 'S')
								 and t.cinsi in
										 (with t as (select ps_menkul_cinsi as txt from dual)
											 select REGEXP_SUBSTR(txt, '[^,]+', 1, level)
												 from t
											 connect by level <=
																	length(regexp_replace(txt, '[^,]*')) + 1
											)
								 and t.durum = 'A'
								 and t.ihrac_sekli = ps_ihrac_sekli
							--and nvl(t.tuzel_bono, 'H') = nvl(pc_tuzel_bono, 'H')
							) t
			 where t.depo_turu = case
							 when pkg_menkul_halkaarz_hesapla.SPK_IZIN_KALAN_SURE(t.id,
																																		ld_islem_tarihi) <= 0 then
								'S'
							 else
								t.depo_turu
						 end
			 order by case
									when ps_doviz <> 'TRY' then
									 t.depo_turu
									else
									 null
								end,
								t.vade,
								t.kalan_naminal;
	
		r_c c%rowtype;
	
	begin
	
		ld_islem_tarihi := pkg_muhasebe.Banka_Tarihi_Bul;
	
		open c;
		loop
			fetch c
				into r_c;
			exit when pn_portfoy_id is not null;
			exit when c%notfound;
		
			select mc.stopaj_oran
				into pn_stopaj_orani
				from men_menkul_cinsleri mc
			 where mc.cins_kodu = r_c.cinsi;
		
			vn_gun_farki := trunc(trunc(r_c.vade) -
														trunc(pkg_muhasebe.Banka_Tarihi_Bul));
			vn_fiyat     := round(100 / (1 + pn_oran * vn_gun_farki / 36500), 8); --PBIYU-1192
		
			--25.03.2016 Erkan Çalışkan
			--ilk satırda trunc kullanıldığından, hatalı olarak daima 100 ün katlarına göre hesaplama yapıyor
			-- halbuki menkul tanıındaki küpüre göre hesaplama yapması lazım.
		
			/*
      vn_nominal :=  trunc( pn_tutar / vn_fiyat ) * 100;
      vn_nominal := trunc(vn_nominal/r_c.kupur) * r_c.kupur;
      */
		
			vn_nominal := pkg_menkul_dibs_hesapla.NominalHesapla(r_c.ISIN,
																													 pn_tutar,
																													 vn_fiyat);
		
			if r_c.kalan >= vn_nominal then
				pn_portfoy_id   := r_c.id;
				ps_isin         := r_c.ISIN;
				pd_isin_vade    := r_c.vade;
				ps_depo_turu    := r_c.depo_turu;
				pn_stopaj_orani := bbvergiorani(pn_musteri_no,
																				ps_emanetmi,
																				r_c.cinsi,
                                        r_c.isin,
                                        ld_islem_tarihi,
                                        pd_vade);
			end if;
		
		end loop;
	
		close c;
	
		if pn_portfoy_id is null then
			pkg_hata.hata_yaz(4979, true); --Girdiginiz vade, tutar, doviz cinsine uygun ISIN bulunamadi
		end if;
	
		vn_gun_farki := trunc(trunc(pd_vade) -
													trunc(pkg_muhasebe.Banka_Tarihi_Bul));
	
		pn_satis_nominal      := vn_nominal;
		pn_satis_tutar        := round(vn_nominal * vn_fiyat / 100, 2);
		pn_satis_birim_fiyat  := vn_fiyat;
		pn_satis_net_oran     := pn_oran * (100 - pn_stopaj_orani) / 100;
		pn_satis_brut_oran    := pn_oran;
		pn_donus_birim_fiyati := round(pn_satis_birim_fiyat *
																	 (1 + pn_oran * vn_gun_farki / 36500.0),
																	 8);
		if trunc(pd_isin_vade) = trunc(pd_vade) then
			pn_donus_birim_fiyati := 100;
		end if;
		pn_donus_brut_tutari   := round(pn_donus_birim_fiyati *
																		pn_satis_nominal / 100,
																		2);
		pn_donus_brut_getiri   := pn_donus_brut_tutari - pn_satis_tutar;
		pn_donus_stopaj_tutari := round((pn_donus_brut_getiri -
																		nvl(pn_komisyon, 0)) * pn_stopaj_orani / 100,
																		2);
		pn_donus_net_tutari    := pn_donus_brut_tutari - pn_donus_stopaj_tutari;
		pn_donus_net_getiri    := pn_donus_brut_getiri - pn_donus_stopaj_tutari;
	
	end;

	Function XIRR(ptable_degerler       vt_degerler,
								ptable_vadeler        vt_vadeler,
								pn_yil_gun_sayisi     number default 365,
								pn_gun_sayisi_yontemi number default 3) return number is
		vn_dizi_boyutu binary_integer;
		vn_dx          number;
		vn_SD          number; --þimdiki deðer
		vn_Y           number; --ödenen (dizinin ilk elemaný)
		vn_NSD         number; --net þimdiki deðer (nSD - nY)
		vn_gecen_gun   binary_integer; --Di - D1
		vn_oran        number;
		vn_alt_sinir   number;
		vn_ust_sinir   number;
		vd_ilk_tarih   date;
		vn_result      number;
	begin
		vn_dizi_boyutu := ptable_degerler.count;
	
		If vn_dizi_boyutu <= 0 Then
			pkg_hata.hata_yaz(4981, true); --Dizi boyutu sýfýr olamaz.
		end if;
	
		--iç iskonto oranýný hesaplar
		If ptable_degerler(0) >= 0 Then
			--ilk deðer (maliyet) negatif olmalý
			pkg_hata.hata_yaz(4982, true); --XIRR hesaplamada hata. Nakit akışın ilk değeri negatif olmalıdır.
		end if;
	
		--Excelde olduðu gibi max 100 iterasyonda deðeri bulmaya çalýþýr
	
		vn_dx        := 0.0000000001; --fark dx deðeriden küçükse olursa oran bulunmuþtur.
		vn_Y         := Abs(ptable_degerler(0));
		vd_ilk_tarih := ptable_vadeler(0);
	
		vn_alt_sinir := -1; -- %-100
		vn_ust_sinir := 1;  -- %+100
		vn_oran      := vn_ust_sinir;
	
		vn_result := 0;
	
		For i in 1 .. 100 loop
			vn_SD  := 0;
			vn_NSD := 0;
		
			For k in 1 .. vn_dizi_boyutu - 1 loop
				--05.04.2016 Erkan Çalışkan
				--vn_gecen_gun := ptable_vadeler(K) - vd_ilk_tarih;
				vn_gecen_gun := pkg_menkul_finansal_hesaplama.Gun_Farki_Bul(vd_ilk_tarih,
																																		ptable_vadeler(K),
																																		pn_gun_sayisi_yontemi);
				vn_SD        := vn_SD + ptable_degerler(K) /
												((1 + vn_oran) **
												(vn_gecen_gun / pn_yil_gun_sayisi));
			end loop;
		
			--NSD (net þimdiki deðer), yeterince küçükse oran bulunmuþtur.
			vn_NSD    := vn_SD - vn_Y;
			vn_result := vn_oran;
			exit when Abs(vn_NSD) <= vn_dx;
		
			--oran için, ikiye bölme yöntemi kullanýlýyor
			If vn_NSD < 0 Then
				vn_ust_sinir := vn_oran;
			Else
				vn_alt_sinir := vn_oran;
			End If;
		
			vn_oran := (vn_ust_sinir + vn_alt_sinir) / 2.0;
		end loop;
	
		return vn_result * 100.0; --sonuç % (yüzde) olarak geriye dönüyor
	End;

	Function XNPV(pn_irr_oran           number,
								ptable_degerler       vt_degerler,
								ptable_vadeler        vt_vadeler,
								pn_yil_gun_sayisi     number default 365,
								pn_gun_sayisi_yontemi number default 3) return number is
		vn_dizi_boyutu binary_integer;
		vn_SD          number; --net þimdiki deðer (nSD - nY)
		vn_gecen_gun   binary_integer; --Di - D1
		vn_oran        number;
		vd_ilk_tarih   date;
		vn_result      number;
	begin
		vn_dizi_boyutu := ptable_degerler.count;
	
		If vn_dizi_boyutu <= 0 Then
			pkg_hata.hata_yaz(4981, true); --'Dizi boyutu sýfýr olamaz.'
		end if;
	
		vd_ilk_tarih := ptable_vadeler(0);
		vn_oran      := pn_irr_oran / 100.0; --oran % (yüzde) þekilnde geldiðinden, 100'e bölüþünüyor
		vn_SD        := 0;
		vn_result    := 0;
	
		For k in 1 .. vn_dizi_boyutu - 1 loop
			vn_gecen_gun := ptable_vadeler(K) - vd_ilk_tarih;
			--05.04.2016 Erkan Çalışkan
			--vn_gecen_gun := ptable_vadeler(K) - vd_ilk_tarih;
			vn_gecen_gun := pkg_menkul_finansal_hesaplama.Gun_Farki_Bul(vd_ilk_tarih,
																																	ptable_vadeler(K),
																																	pn_gun_sayisi_yontemi);
			vn_SD        := vn_SD +
											ptable_degerler(K) /
											((1 + vn_oran) ** (vn_gecen_gun / pn_yil_gun_sayisi));
		end loop;
	
		vn_result := vn_SD;
	
		return round(vn_result, 8);
	End;

	Function IRROranHesaplaBB(pn_referans number) return number is
		vtable_degerler vt_degerler;
		vtable_vadeler  vt_vadeler;
	
		vc_isin         varchar2(12);
		vc_kuponlu      char(1);
		vd_satis_tarihi date;
		vn_maliyet      number;
		vn_vs_fiyat     number;
		vd_vade_tarihi  date;
		vn_index        binary_integer;
	
		vn_kayit_sayisi number := 0;
	
		cursor C_kuponlar is
			select k.vade, k.kupon_faizi
				from men_kupon k
			 where k.isin = vc_isin
				 and k.vade > vd_satis_tarihi
				 and k.vade < vd_vade_tarihi --28.06.2019 EÇ, son vade bb_satis tablosundan ekleniyor
			union
			select s.vade_tarihi vade, s.gerialis_birim_fiyat kupon_faizi
				from bb_satis s
			 where s.referans = pn_referans
			 order by vade;
	begin
		/*
    29-01-2015 ERKAN ÇALIÞKAN
    
    BB_SATIS tablosundaki kayýt için IRR oran hesaplar.
    
    Böylece müþteri bazlý olarak faiz gideri izlenebilecektir.
    */
	
		--maliyet ve isin alýnýyor
		select bb.reeskont_maliyet,
					 trim(bb.isin),
					 bb.reeskont_acilis_tarih,
					 bb.vade_tarihi,
					 bb.gerialis_birim_fiyat
			into vn_maliyet,
					 vc_isin,
					 vd_satis_tarihi,
					 vd_vade_tarihi,
					 vn_vs_fiyat
			from bb_satis bb
		 where bb.referans = pn_referans;
	
		--isin kuponlu mu?
		select nvl(m.kuponlu, '')
			into vc_kuponlu
			from men_tanim m
		 where m.isin = vc_isin;
	
		if vc_kuponlu = 'E' then
			--kuponlu
			select count(*)
				into vn_kayit_sayisi
				from men_kupon k
			 where k.isin = vc_isin
				 and k.vade > vd_satis_tarihi
				 and k.vade < vd_vade_tarihi;
		
			if vn_kayit_sayisi = 0 then
				--nakit akış hiç kupon içermiyor.
				vtable_degerler(0) := -vn_maliyet;
				vtable_degerler(1) := vn_vs_fiyat;
			
				vtable_vadeler(0) := vd_satis_tarihi;
				vtable_vadeler(1) := vd_vade_tarihi;
			else
				-- en az bir kupon içeriyor
				vtable_degerler(0) := -vn_maliyet;
				vtable_vadeler(0) := vd_satis_tarihi;
				vn_index := 1;
				for r_kuponlar in C_kuponlar loop
					vtable_degerler(vn_index) := r_kuponlar.kupon_faizi;
					vtable_vadeler(vn_index) := r_kuponlar.vade;
					vn_index := vn_index + 1;
				end loop;
			end if;
		else
			--iskontolu
			--IRR ile hesaplanmasýna karar verilene kadar
			--mevcut (basit faiz) yöntemle hespalanmaya devam ediliyor
		
			vtable_degerler(0) := -vn_maliyet;
			vtable_degerler(1) := vn_vs_fiyat;
		
			vtable_vadeler(0) := vd_satis_tarihi;
			vtable_vadeler(1) := vd_vade_tarihi;
		
			--return vn_irr_oran;
		end if;
	
		return XIRR(vtable_degerler, vtable_vadeler);
	end;

	Function IRRFiyatHesaplaBB(pn_referans    number,
														 pd_rees_tarihi date,
														 pn_irr_oran    number) return number is
		vtable_degerler vt_degerler;
		vtable_vadeler  vt_vadeler;
	
		vc_isin         varchar2(12);
		vc_kuponlu      char(1);
		vn_vs_fiyat     number;
		vd_vade_tarihi  date;
		vn_index        binary_integer;
		vn_kupon_faizi  number;
		vd_satis_tarihi date;
		vd_yarin        date;
		vn_gun          number;
		vn_satis_fiyati number;
		vn_result       number;
	
		vn_kayit_sayisi number := 0;
	
		cursor C_kuponlar is
			select k.vade, k.kupon_faizi
				from men_kupon k
			 where k.isin = vc_isin
				 and k.vade > pkg_muhasebe.Banka_Tarihi_Bul --Reeskont T+1 hesaplanıyor ama nakit akış T den başlamalı.
				 and k.vade < vd_vade_tarihi
			union
			select s.vade_tarihi vade, s.gerialis_birim_fiyat kupon_faizi
				from bb_satis s
			 where s.referans = pn_referans
			 order by vade;
	
	begin
		/*
    29-01-2015 ERKAN ÇALIÞKAN
    
    BB_SATIS tablosundaki kayýt için IRR fiyat hesaplar.
    
    Böylece müþteri bazlý olarak faiz gideri izlenebilecektir.
    */
	
		--maliyet ve isin alýnýyor
		select trim(bb.isin),
					 bb.Reeskont_Acilis_Tarih,
					 bb.vade_tarihi,
					 bb.gerialis_birim_fiyat,
					 bb.Reeskont_Maliyet
			into vc_isin,
					 vd_satis_tarihi,
					 vd_vade_tarihi,
					 vn_vs_fiyat,
					 vn_satis_fiyati
			from bb_satis bb
		 where bb.referans = pn_referans;
	
		--isin kuponlu mu?
		select nvl(m.kuponlu, '')
			into vc_kuponlu
			from men_tanim m
		 where m.isin = vc_isin;
	
		if vc_kuponlu = 'E' then
			--kuponlu
			select count(*)
				into vn_kayit_sayisi
				from men_kupon k
			 where k.isin = vc_isin
				 and k.vade > pkg_muhasebe.Banka_Tarihi_Bul
				 and k.vade <= vd_vade_tarihi;
		
			if vn_kayit_sayisi = 0 then
				--nakit akış hiç kupon içermiyor.
				vtable_degerler(0) := 0;
				vtable_degerler(1) := vn_vs_fiyat;
			
				vtable_vadeler(0) := pd_rees_tarihi;
				vtable_vadeler(1) := vd_vade_tarihi;
			else
				-- en az bir kupon içeriyor
				vtable_degerler(0) := 0;
				vtable_vadeler(0) := pd_rees_tarihi;
				vn_index := 1;
				for r_kuponlar in C_kuponlar loop
					vtable_degerler(vn_index) := r_kuponlar.kupon_faizi;
					vtable_vadeler(vn_index) := r_kuponlar.vade;
					vn_index := vn_index + 1;
				end loop;
			end if;
		
		else
			--iskontolu
		
			--IRR ile hesaplanmasýna karar verilene kadar
			--mevcut (basit faiz) yöntemle hespalanmaya devam ediliyor
		
			vtable_degerler(0) := 0;
			vtable_degerler(1) := vn_vs_fiyat;
		
			vtable_vadeler(0) := pd_rees_tarihi;
			vtable_vadeler(1) := vd_vade_tarihi;
		
			/*
      vd_yarin := pd_rees_tarihi+1;
      
        If vd_yarin > vd_vade_tarihi Then
            vd_yarin := vd_vade_tarihi;
        End If;
      
        vn_gun := vd_yarin - vd_satis_tarihi;
      
        vn_result := round(vn_satis_fiyati * (1 + vn_irr_oran * vn_gun / 36500.0), 8)    ;
      
        return vn_result;
        */
		end if;
	
		vn_result := XNPV(pn_irr_oran, vtable_degerler, vtable_vadeler);
	
		return vn_result;
	end;

	Function FaizGideriBB(pn_referans number, pd_rees_tarihi date)
		return number is
	
		vn_nominal          number;
		vn_maliyet          number := 0;
		vn_irr_oran         number := 0;
		vn_irr_fiyati       number := 0;
		vn_irr_degeri       number := 0;
		vn_result           number := 0;
		vn_reeskont_maliyet number;
	begin
		/*
    29-01-2015 ERKAN ÇALIÞKAN
    
    IRR yönteme göre faiz giderini hesaplar.
    
    */
	
		--maliyet ve isin alýnýyor
		select nvl(bb.reeskont_maliyet, bb.satis_birim_fiyat) reeskont_maliyet,
					 bb.kalan_nominal,
					 bb.irr_orani
			into vn_reeskont_maliyet, vn_nominal, vn_irr_oran
			from bb_satis bb
		 where bb.referans = pn_referans;
	
		--09.10.2018 Erkan Çalışkan (PY-14262)        
	
		if vn_irr_oran is null then
			vn_irr_oran := pkg_menkul_hesapla.IRROranHesaplaBB(pn_referans);
		end if;
	
		vn_irr_fiyati := IRRFiyatHesaplaBB(pn_referans,
																			 pd_rees_tarihi,
																			 vn_irr_oran);
	
		vn_maliyet    := round(vn_nominal * vn_reeskont_maliyet / 100.0, 2);
		vn_irr_degeri := round(vn_nominal * vn_irr_fiyati / 100.0, 2);
	
		vn_result := round(vn_irr_degeri - vn_maliyet, 2);
	
		return vn_result;
	end;

	Procedure BB_Geri_Alis_Hesapla(pn_Talep_Nominal  in number,
																 pn_Talep_Tutar    in number,
																 pn_Faiz_Orani     in number,
																 pn_Satis_referans in number,
																 
																 p_Burut_Tutar        out number,
																 p_Net_Tutar          out number,
																 p_kalan_nominal      out number,
																 p_birim_fiyat        out number,
																 p_stopaj_kesintisi   out number,
																 p_stopaj_oran        out number,
																 p_bugunku_degeri     out number,
																 p_vadesindeki_degeri out number,
																 p_ga_nominal         out number,
																 p_isin               out varchar2,
																 pn_bugunku_fiyat     out number,
																 pn_faiz_oran         out number,
																 pn_odenen_net_tutar  out number,
																 pn_ihrac_farki       out number,
																 pn_taahhut           out number,
																 pn_brut_getiri       out number
																 
																 ) is
	
		vn_satis_fiyati  number;
		vn_kalan_nominal number;
		vn_gecen_gun     number;
		vn_ga_fiyat      number;
		vc_emanet        char(1);
		vn_satis_faiz    number;
		vn_musteri_no    number;
		vd_itfa          date;
		vd_satis_tarih   date;
		vc_cins_kodu     varchar2(10);
		vc_isin          varchar2(25);
		vn_bono_tipi     number;
		vn_taahhut       number;
		vd_ga_tarihi     date;
		vc_erken         varchar2(1) default 'H';
	
		ld_yasayan_kupon_vadesi date;
    
    ld_kademeli_stopaj_bas_tar date;
    ld_kademeli_stopaj_bit_tar date;
	begin
		select s.satis_birim_fiyat,
					 s.kalan_nominal,
					 trunc(pkg_muhasebe.Banka_Tarihi_Bul) - trunc(s.satis_tarihi),
					 s.isin,
					 s.emanet_eh,
					 s.gerialis_birim_fiyat,
					 s.satis_faiz_oran,
					 s.musteri_no,
					 s.itfa_tarihi,
					 s.isin,
					 s.bono_tipi,
					 s.satis_tarihi,
					 s.kalan_taahhut,
					 s.vade_tarihi,
           s.stopaj_oran
			into vn_satis_fiyati,
					 vn_kalan_nominal,
					 vn_gecen_gun,
					 p_isin,
					 vc_emanet,
					 vn_ga_fiyat,
					 vn_satis_faiz,
					 vn_musteri_no,
					 vd_itfa,
					 vc_isin,
					 vn_bono_tipi,
					 vd_satis_tarih,
					 vn_taahhut,
					 vd_ga_tarihi,
           p_stopaj_oran
			from bb_satis s
		 where s.referans = pn_Satis_referans;
	
		if vn_bono_tipi < 3 then
			p_birim_fiyat    := round(vn_satis_fiyati *
																(1 + pn_Faiz_Orani * vn_gecen_gun / 36500.0),
																8);
			pn_bugunku_fiyat := round(vn_satis_fiyati *
																(1 + vn_satis_faiz * vn_gecen_gun / 36500.0),
																8);
			
      --18.04.2022 Erkan Çaliskan
      --PBIYU-1570
      --8 hane dijite geciste vade dönüs tutarinda kusurat farki olustugudan
      --05.02.2022 tarihinden once yapilan satislarin vade donusleri
      --3 hane olarak hesaplanýyor
      
      if trunc(vd_ga_tarihi) = trunc(pkg_muhasebe.banka_tarihi_bul) and trunc(vd_satis_tarih) < '05.02.2022' then
				p_birim_fiyat    := round(vn_satis_fiyati *
																(1 + pn_Faiz_Orani * vn_gecen_gun / 36500.0),
																3);
			  pn_bugunku_fiyat := round(vn_satis_fiyati *
																(1 + vn_satis_faiz * vn_gecen_gun / 36500.0),
																3);
			end if;
      
      --Itfa bugun ise fiyat 100 dur!!!
		
			if trunc(vd_itfa) = trunc(pkg_muhasebe.banka_tarihi_bul) then
				p_birim_fiyat    := 100;
				pn_bugunku_fiyat := 100;
			end if;
		
		else
			-- kuponlu demekki
		
			if trunc(vd_ga_tarihi) > trunc(pkg_muhasebe.Banka_Tarihi_Bul) then
				vc_erken := 'E';
			end if;
		
			/*
        04.07.2016 Erkan Çalışkan
        
      işlem vadesi ilk kupon tarihinden önce ise; yani arada kupon ödenmeyecekse
      hespalamalar iskontolu gibi yapılacakmış.
      
      TYHAZ-1050
      */
			ld_yasayan_kupon_vadesi := YasayanKuponVadesi(pc_isin  => vc_isin,
																										pd_tarih => vd_satis_tarih);
			if ISINCinsKodu(vc_isin) = 'AKTEBOND' and
				 trunc(pkg_muhasebe.Banka_Tarihi_Bul) < ld_yasayan_kupon_vadesi then
				--henüz kupon itfası görmemiş, iskontolu gibi hesaplanıyor.
				p_birim_fiyat    := round(vn_satis_fiyati *
																	(1 +
																	pn_Faiz_Orani * vn_gecen_gun / 36500.0),
																	8);
				pn_bugunku_fiyat := round(vn_satis_fiyati *
																	(1 +
																	vn_satis_faiz * vn_gecen_gun / 36500.0),
																	8);
			else
			
				if trunc(vd_ga_tarihi) > trunc(pkg_muhasebe.Banka_Tarihi_Bul) then
					vc_erken := 'E';
				end if;
			
				p_birim_fiyat    := KuponluBonoGeriAlisFiyatiErken(vc_isin,
																													 vd_satis_tarih,
																													 pkg_muhasebe.Banka_Tarihi_Bul,
																													 vn_satis_fiyati,
																													 pn_Faiz_Orani,
																													 vc_erken);
				pn_bugunku_fiyat := KuponluBonoGeriAlisFiyatiErken(vc_isin,
																													 vd_satis_tarih,
																													 pkg_muhasebe.Banka_Tarihi_Bul,
																													 vn_satis_fiyati,
																													 vn_satis_faiz,
																													 vc_erken);
			end if;
		end if;
	
		p_ga_nominal := pn_Talep_Nominal;
		if nvl(pn_Talep_Nominal, 0) = 0 then
			p_ga_nominal := trunc(pn_Talep_Tutar / p_birim_fiyat) * 100;
		end if;
	
		select t.cinsi
			into vc_cins_kodu
			from men_tanim t
		 where t.isin = p_isin;
		
    --23.12.2021 - 31.03.2021 tarihleir arası kademeli stopaj geçerli
    
    ld_kademeli_stopaj_bas_tar := pkg_parametre.Deger_Al_K_D('KADEMELI_STOPAJ_BAS_TARIH');
    ld_kademeli_stopaj_bit_tar := pkg_parametre.Deger_Al_K_D('KADEMELI_STOPAJ_BIT_TARIH');
          
    if (vd_satis_tarih between ld_kademeli_stopaj_bas_tar and ld_kademeli_stopaj_bit_tar) 
         or p_stopaj_oran is null then
       
       p_stopaj_oran := bbvergiorani(vn_musteri_no,
																	vc_emanet,
																	vc_cins_kodu,
																	vc_isin,
                                  vd_satis_tarih,
                                  pkg_muhasebe.Banka_Tarihi_Bul
                                  );
    end if;
      
 		pn_ihrac_farki := p_ga_nominal -
											round((p_ga_nominal * vn_satis_fiyati) / 100, 2);
		p_Burut_Tutar  := round((p_ga_nominal * p_birim_fiyat) / 100, 2);
		pn_brut_getiri := p_Burut_Tutar -
											round((p_ga_nominal * vn_satis_fiyati) / 100, 2);
	
		if p_stopaj_oran = 0 then
			p_stopaj_kesintisi := 0;
		else
			if vn_bono_tipi < 3 then
				p_stopaj_kesintisi := round(round(p_ga_nominal *
																					(p_birim_fiyat - vn_satis_fiyati) / 100,
																					2) * p_stopaj_oran / 100,
																		2);
			else
				p_stopaj_kesintisi := VergiHesaplaBB(pkg_muhasebe.banka_tarihi_bul,
																						 pn_satis_referans,
																						 vn_musteri_no,
																						 p_ga_nominal,
																						 p_birim_fiyat);
			end if;
		end if;
	
		pn_faiz_oran        := pn_Faiz_Orani;
		p_Net_Tutar         := p_Burut_Tutar - p_stopaj_kesintisi;
		pn_odenen_net_tutar := p_Net_Tutar;
		p_kalan_nominal     := vn_kalan_nominal - p_ga_nominal;
		if p_kalan_nominal = 0 then
			pn_taahhut := vn_taahhut; -- hepsini bozmus
		else
			pn_taahhut := round(p_ga_nominal * vn_ga_fiyat / 100, 2);
		end if;
	
		/**
    *
    *   07.06.2016 Erkan Çalışkan
    *
    *   bazı bb satış kayıtlarında TAAHHUT alanı null olduğundan
    *   hespalama yoluna gidildi. Tüm kaytlşarda taahhüt dolduğu emin
    *   olunduktan sonra yukarıdaki if buloğu açılabilr.
    *
    */
		--
		pn_taahhut := round(p_ga_nominal * vn_ga_fiyat / 100, 2);
		--
	
		p_bugunku_degeri     := round(p_kalan_nominal * pn_bugunku_fiyat / 100,
																	2);
		p_vadesindeki_degeri := round(p_kalan_nominal * vn_ga_fiyat / 100, 2);
	
	end;

	--**************************************************************************************************************************

	Function BugunkuDegerBono(p_referans number) return number is
		ln_bugunku_deger number;
		ln_fiyat         number;
		ln_nominal       number;
	begin
	
		select bb.kalan_nominal
			into ln_nominal
			from bb_satis bb
		 where bb.referans = p_referans;
	
		ln_fiyat         := BugunkuFiyatBono(p_referans);
		ln_bugunku_deger := round(ln_nominal * ln_fiyat / 100, 2);
	
		return ln_bugunku_deger;
	
	exception
		when no_data_found then
			return 0;
		
	end;
	--**************************************************************************************************************************

	Function BugunkuNetDegerBono(p_referans number) return number is
		ln_bugunku_deger number;
		ld_banka_tarihi  date;
		ln_vergi         number;
		ln_bugunku_fiyat number;
	
		cursor c_bb is
			select * from bb_satis bb where bb.referans = p_referans;
	
		r_bb c_bb%rowtype;
	
	begin
		ld_banka_tarihi := pkg_muhasebe.Banka_Tarihi_Bul;
	
		open c_bb;
		fetch c_bb
			into r_bb;
		close c_bb;
	
		ln_bugunku_fiyat := BugunkuFiyatBono(p_referans);
		ln_bugunku_deger := BugunkuDegerBono(p_referans);
	
		ln_vergi := VergiHesaplaBB(pd_tarih          => ld_banka_tarihi,
															 pn_satis_referans => r_bb.referans,
															 pn_musteri_no     => r_bb.musteri_no,
															 pn_nominal        => r_bb.kalan_nominal,
															 pn_fiyat          => ln_bugunku_fiyat);
	
		return round(ln_bugunku_deger - ln_vergi, 2);
	
	exception
		when no_data_found then
			return 0;
		
	end;
	--**************************************************************************************************************************

	Function BugunkuFiyatBono(p_referans number) return number is
		ln_bugunku_deger number;
		ld_banka_tarihi  date;
	
		lc_isin             men_tanim.isin%type;
		ld_satis_tarihi     date;
		ln_satis_fiyati     number;
		ln_satis_faiz_orani number;
	begin
	
		/**
    *  10.02.2017 Erkan Çalışkan
    *
    *  Kuponlu için bugünkü fiyat hesaplaması eklendi.
    *
    */
	
		ld_banka_tarihi := pkg_muhasebe.Banka_Tarihi_Bul;
	
		select bb.isin,
					 bb.satis_tarihi,
					 bb.satis_birim_fiyat,
					 (nvl(bb.base_satis_faiz_oran, bb.satis_faiz_oran) +
					 nvl(bb.guncel_ek_getiri_orani, 0)) satis_faiz_oran
			into lc_isin, ld_satis_tarihi, ln_satis_fiyati, ln_satis_faiz_orani
			from bb_satis bb
		 where bb.referans = p_referans;
	
		if ISINKuponlumu(lc_isin) = 'E' then
			ln_bugunku_deger := KuponluBonoGeriAlisFiyati(ps_isin         => lc_isin,
																										pd_satis_tarih  => ld_satis_tarihi,
																										pd_ga_tarih     => ld_banka_tarihi,
																										pn_satis_fiyati => ln_satis_fiyati,
																										pn_ga_faizi     => ln_satis_faiz_orani);
		else
			ln_bugunku_deger := GAFiyatHesaplaIskontoluBB(pd_tarih        => ld_banka_tarihi,
																										pn_ga_orani     => ln_satis_faiz_orani,
																										pd_satis_tarihi => ld_satis_tarihi,
																										pn_satis_fiyati => ln_satis_fiyati);
		end if;
	
		return ln_bugunku_deger;
	
	exception
		when no_data_found then
			return 0;
		
	end;

	---****************************************************************--

	function OnaydakiGeriAlisNominal(p_satis_referans number) return number is
		vn_sum    number := 0;
		vn_return number := 0;
	
	begin
	
		select sum(t.nominal)
			into vn_sum
			from bnspr.bb_geri_alis_tx t
		 where bnspr.pkg_Tx.Islem_bitmis_mi(t.tx_no) = 0 --bitmemiþ iþlem
			 and t.satis_referans = p_satis_referans;
	
		return nvl(vn_sum, 0);
	
	end;
	---****************************************************************--
	function ISINIhracTarihi(pc_isin varchar2) return date is
		vd_tarih date;
	begin
		select m.ihrac_tarihi
			into vd_tarih
			from men_tanim m
		 where m.isin = pc_isin;
	
		return vd_tarih;
	end;

	---****************************************************************--
	function ISINItfaTarihi(pc_isin varchar2) return date is
		vd_tarih date;
	begin
		select m.vade into vd_tarih from men_tanim m where m.isin = pc_isin;
	
		return vd_tarih;
	end;
	---***************************************************************----
	function KuponBaslamaTarihi(pc_isin varchar2, pd_tarih date) return date is
		vd_tarih date;
	begin
		/*
    30.01.2015 ERKAN ÇALIÞKAN
    
    Tarih parametresini içine alan kuponun baþlangýç tarihini döner.
    Özellikle geçen gün (birikmiþ faiz) hesaplamalarýnda kullanýlýr.
    */
	
		SELECT MAX(k.vade)
			into vd_tarih
			From men_kupon k
		 WHERE k.isin = pc_isin
			 and k.vade <= pd_tarih;
	
		IF vd_tarih is null then
			-- IHRAÇ TARÝHÝNDEN HEMEN SONRA ALINMIÞ. BAÞLANGIÇ TARÝHÝ OLARAK ÝHRAÇ TARÝHÝ ALINIYOR
			vd_tarih := ISINIhracTarihi(pc_isin);
		END if;
	
		return vd_tarih;
	end;
	-----------------------------------------------------------------------------------

	function YasayanKuponVadesi(pc_isin varchar2, pd_tarih date) return date is
		vd_tarih date;
	begin
		/*
    30.01.2015 ERKAN ÇALIÞKAN
    
    Tarih parametresini içine alan kuponun vadesini döner.
    */
	
		SELECT min(k.vade)
			into vd_tarih
			From men_kupon k
		 WHERE k.isin = pc_isin
			 and k.vade > pd_tarih;
	
		IF vd_tarih is null then
			-- SON KUPONDAN ALINMIÞ OLABÝLÝR. KUPON VADESÝ, ÝTFA TARÝHÝ ALINIYOR
			vd_tarih := ISINItfaTarihi(pc_isin);
		END if;
	
		return vd_tarih;
	end;
	-----------------------------------------------------------------------------------

	function KuponGunSayisi(pc_isin varchar2, pd_tarih date) return number is
		vn_gun_sayisi number;
	begin
		/*
    30.01.2015 ERKAN ÇALIÞKAN
    
    Ýçinde bulunduðumuz (yaþayan ) kuponun toplam gün sayýsý geri döner.
    */
		vn_gun_sayisi := (YasayanKuponVadesi(pc_isin, pd_tarih) -
										 KuponBaslamaTarihi(pc_isin, pd_tarih));
	
		return vn_gun_sayisi;
	end;

	-----------------------------------------------------------------------------------
	function KuponOrani(pc_isin varchar2, pd_tarih date) return number is
		vn_oran number;
	begin
		/*
    23.03.2015 ERKAN ÇALIÞKAN
    
    pd_tarih tarihndeki kuponun oranýný geri döner.
    */
	
		SELECT k.kupon_faizi
			into vn_oran
			From men_kupon k
		 WHERE k.isin = pc_isin
			 and k.vade = pd_tarih;
	
		return vn_oran;
	end;

	-----------------------------------------------------------------------------------
	/*
  function BirikmisKuponFaizi(pc_isin varchar2, pd_tarih date) return number is
       vn_kupon_orani number;
       vd_kupon_baslangic_tarihi date;
       vn_gecen_gun_sayisi number;
       vn_kupon_gun_sayisi number;
       vn_birikmis_faiz number;
   begin
       /*
       30.01.2015 ERKAN ÇALIÞKAN
  
       Birikmiþ faiz oranýný geri döner.
  
  
       vn_kupon_orani := KuponOrani(pc_isin ,pd_tarih);
       vd_kupon_baslangic_tarihi := KuponBaslamaTarihi(pc_isin ,pd_tarih);
       vn_kupon_gun_sayisi := KuponGunSayisi(pc_isin ,pd_tarih);
       vn_gecen_gun_sayisi := (pd_tarih - vd_kupon_baslangic_tarihi);
  
       vn_birikmis_faiz := vn_kupon_orani / vn_kupon_gun_sayisi * vn_gecen_gun_sayisi;
  
       return vn_birikmis_faiz;
   end;
   */

	-----------------------------------------------------------------------------------

	function ItfaKuponSayisi(pc_isin         varchar2,
													 pd_tarih        date,
													 pd_satis_tarihi date) return number is
		vn_adet number;
	begin
		/*
    31.01.2015 ERKAN ÇALIÞKAN
    
    alis tarihi ile pd_tarih tarih arasında itfa olmuş kupon sayısını döner.
    */
	
		SELECT count(k.vade)
			into vn_adet
			From men_kupon k
		 WHERE k.isin = pc_isin
			 and k.vade > pd_satis_tarihi
			 and k.vade < pd_tarih;
	
		return vn_adet;
	end;

	-----------------------------------------------------------------------------------

	function KalanKuponSayisi(pc_isin varchar2, pd_tarih date) return number is
		vn_adet number;
	begin
		/*
    30.01.2015 ERKAN ÇALIÞKAN
    
    pd_tarih tarihnde, itfa tarihine kadar olan kalan kupon sayýsýný döner.
    */
	
		SELECT count(k.vade)
			into vn_adet
			From men_kupon k
		 WHERE k.isin = pc_isin
			 and k.vade > pd_tarih;
	
		return vn_adet;
	end;

	-----------------------------------------------------------------------------------

	function TemizFiyat(pn_kirli_fiyat          number,
											pn_birikmis_kupon_faizi number) return number is
		vn_tfiyat number;
	begin
		/*
    30.01.2015 ERKAN ÇALIÞKAN
    
    Temiz fiyatım döner.
    */
	
		vn_tfiyat := round(pn_kirli_fiyat - pn_birikmis_kupon_faizi, 8);
	
		return vn_tfiyat;
	end;

	-----------------------------------------------------------------------------------

	function KuponBasiFazlaOdeme(pn_kirli_fiyat          number,
															 pn_birikmis_kupon_faizi number,
															 pn_kalan_kupon_sayisi   number) return number is
		vn_tfiyat number;
		vn_kbfo   number;
	begin
		/*
    30.01.2015 ERKAN ÇALIÞKAN
    
    Kupon başı fazla ödemeyi döner.
    */
	
		if pn_kalan_kupon_sayisi = 0 then
			return 0;
		end if;
	
		vn_tfiyat := TemizFiyat(pn_kirli_fiyat, pn_birikmis_kupon_faizi);
		vn_kbfo   := round((vn_tfiyat - 100) / pn_kalan_kupon_sayisi, 8);
	
		if vn_kbfo < 0 then
			vn_kbfo := 0;
		end if;
	
		return vn_kbfo;
	end;

	--************************************************************---

	function ISINVergiyeTabimi(pc_isin varchar2) return char is
		vc_yurtdisi_ihracli char(1);
		vd_ihrac_tarihi     date;
	begin
		select m.yurtdisi_ihracli, m.ihrac_tarihi
			into vc_yurtdisi_ihracli, vd_ihrac_tarihi
			from men_tanim m
		 where m.isin = pc_isin;
	
		--01.06.2016 Erkan Çalışkan
		--kademeli stopaj yapısı gereği kapatıldı.
		/*
    if nvl(vc_yurtdisi_ihracli,'H') = 'E' then
       return 'H';
    end if;
    */
	
		if vd_ihrac_tarihi < to_date('01.01.2006', 'dd.MM.yyyy') then
			return 'H';
		end if;
	
		return 'E';
	end;

	--************************************************************---

	function MusteriVergiyeTabimi(pn_musteri_no number) return char is
		vc_musteri_tur_kod gnl_musteri.musteri_tur_kod%type;
	begin
		select m.musteri_tur_kod
			into vc_musteri_tur_kod
			from gnl_musteri m
		 where m.musteri_no = pn_musteri_no;
	
		if trim(vc_musteri_tur_kod) IN ('B', 'A') then
			return 'H';
		end if;
	
		return 'E';
	end;

	--************************************************************---
	function ISINCinsKodu(pc_isin varchar2) return char is
		vc_cinsi men_tanim.cinsi%type;
	begin
		select m.cinsi into vc_cinsi from men_tanim m where m.isin = pc_isin;
	
		return vc_cinsi;
	end;

	--************************************************************---

	function VergiOrani(pn_musteri_no number,
											pc_isin       varchar2,
											pc_emanetmi   varchar2) return number is
		vc_cins_kodu       varchar2(10);
		vc_bankamiz_ihraci char(1);
		vn_vergi_orani     number;
		vc_musteri_tur_kod char(1);
		vc_firma_tipi      varchar2(10);
	
		vn_ihracci_kurum   number;
		vc_yurt_disi_ihrac varchar2(1);
		vn_ay_sayisi       number;
		vs_ulke_kodu       men_ihrac_kurum.ulke_kod%type;
		vn_kurum_tipi      number;
	begin
	
		--emaneti bizde olmayan kıymetler için stopaj hesaplanmıyor.
		--stopajı karşı kurum kesiyor olması gerekiyor.
		if pc_emanetmi = 'H' then
			return 0;
		end if;
	
		if ISINVergiyeTabimi(pc_isin) = 'H' then
			return 0;
		end if;
	
		--22.12.2016 Erkan Çalışkan
		--TY-7296 fonlarda vergi oranı 0
	
		if yatirim_fonu_mu(pn_musteri_no) = 'E' then
			return 0;
		end if;
	
		vc_cins_kodu := ISINCinsKodu(pc_isin);
	
		select mc.stopaj_oran, mc.kendi_ihracimiz
			into vn_vergi_orani, vc_bankamiz_ihraci
			from men_menkul_cinsleri mc
		 where mc.cins_kodu = vc_cins_kodu;
	
		/*
        01.06.2016 Erkan Çalışkan
            
        Kademeli Stopaj Oranı
            
        tam mükellef kurumlar tarafından yurt dışında ihraç edilen 
        tahvillerden yine aynı maddede sayılan kurumlar tarafından 
        aşağıdaki oranlar üzerinden tevkifat yapılacağı hüküm altına alınmıştır.
    
        i) Vadesi 1 yıla kadar olanlardan elde edilen faizlerinden % 10,
        ii) Vadesi 1 yıl ile 3 yıl arası olanlardan elde edilen faizlerinden % 7,
        iii) Vadesi 3 yıl ile 5 yıl arası olanlardan elde edilen faizlerinden % 3,
        iv) Vadesi 5 yıl ve daha uzun olanlardan elde edilen faizlerinden %0
    
    */
	
		select t.ihracci_kurum,
					 nvl(t.yurtdisi_ihracli, 'H'),
					 months_between(t.vade, t.ihrac_tarihi),
					 i.ulke_kod,
					 i.kurum_tipi
			into vn_ihracci_kurum,
					 vc_yurt_disi_ihrac,
					 vn_ay_sayisi,
					 vs_ulke_kodu,
					 vn_kurum_tipi
			from men_tanim t, men_ihrac_kurum i
		 where t.ihracci_kurum = i.id
			 and t.isin = pc_isin;
	
		--tam mükellef kurumlarca yurt dıdışında ihraç edilmiş kıymet
		if vs_ulke_kodu = 'TR' and vn_kurum_tipi <> 1 and
			 vc_yurt_disi_ihrac = 'E' then
			if vn_ay_sayisi >= 12 and vn_ay_sayisi < 36 then
				vn_vergi_orani := 7;
			end if;
		
			if vn_ay_sayisi >= 36 and vn_ay_sayisi < 60 then
				vn_vergi_orani := 3;
			end if;
		
			if vn_ay_sayisi >= 60 then
				vn_vergi_orani := 0;
			end if;
		
			return nvl(vn_vergi_orani, 0);
		end if;
	
		--Vergi oranı kontrolü, kendi ihracımız ve diğer kıymetler diye ikiy eayrılıyor
	
		if vc_bankamiz_ihraci = 'E' then
			--yurt içi yerleşik banka/aracı kurumlardan vergi kesilmiyor.
			--Ledia hanımın yorumu
			if pkg_musteri.tur(pn_musteri_no) in ('B', 'A') and
				 pkg_musteri.yurt_ici_disi(pn_musteri_no) = 'I' then
				return 0;
			end if;
		
			return vn_vergi_orani;
		else
			if MusteriVergiyeTabimi(pn_musteri_no) = 'H' then
				return 0;
			end if;
		
			--Tüzel müşteriler için firma tipi kontrol ediliyor.
			select m.Musteri_Tur_Kod
				into vc_musteri_tur_kod
				from gnl_musteri m
			 where m.musteri_no = pn_musteri_no;
		
			if vc_musteri_tur_kod = 'T' then
				select b.firma_tipi
					into vc_firma_tipi
					from gnl_firmadetay_bilgi b
				 where b.musteri_no = pn_musteri_no;
			
				-- sermaye şirketleri ve fonlarında vergi oranı sıfırdır.
				if vc_firma_tipi = '3' or vc_firma_tipi = '4' or
					 vc_firma_tipi = '6' or vc_firma_tipi = '8' or
					 vc_firma_tipi = '9' or vc_firma_tipi = '32' or
					 vc_firma_tipi = '33' or vc_firma_tipi = '42' then
				
					return 0;
				end if;
			end if;
		end if;
		--Buraya kadar geldiyse, vergi istisnası yok demektir.
		return vn_vergi_orani;
	
	EXCEPTION
		WHEN OTHERS THEN
			return vn_vergi_orani;
	end;
	--------------------------------------
	function KuponluBonoGeriAlisFiyati(ps_isin         varchar2,
																		 pd_satis_tarih  date,
																		 pd_ga_tarih     date,
																		 pn_satis_fiyati number,
																		 pn_ga_faizi     number) return number is
	begin
		return KuponluBonoGeriAlisFiyatiErken(ps_isin,
																					pd_satis_tarih,
																					pd_ga_tarih,
																					pn_satis_fiyati,
																					pn_ga_faizi,
																					'H');
	end;
	--------------------------
	function KuponluBonoGeriAlisFiyatiErken(ps_isin         varchar2,
																					pd_satis_tarih  date,
																					pd_ga_tarih     date,
																					pn_satis_fiyati number,
																					pn_ga_faizi     number,
																					ps_erkenmi      varchar2)
		return number is
		vn_kupon_araligi  number;
		vn_bilesikVerim   number;
		vn_kuponFaizi     number;
		vn_anaparaBiriken number;
		vn_kuponBiriken   number default 0;
		vd_itfa           date;
		cursor c is
			select *
				from men_kupon k
			 where k.vade > pd_satis_tarih
				 and ((nvl(ps_erkenmi, 'H') = 'H' and k.vade < trunc(pd_ga_tarih)) or
						 (nvl(ps_erkenmi, 'H') = 'E' and k.vade <= trunc(pd_ga_tarih)))
				 and k.isin = ps_isin;
		r_c c%rowtype;
	
	begin
	
		select t.vade into vd_itfa from men_tanim t where t.isin = ps_isin;
	
		if trunc(vd_itfa) = trunc(pd_ga_tarih) then
			select k.kupon_faizi
				into vn_kuponFaizi
				from men_kupon k
			 where k.isin = ps_isin
				 and k.vade = pd_ga_tarih;
			return vn_kuponFaizi;
		end if;
	
		select t.kupon_gun_araligi
			into vn_kupon_araligi
			from men_tanim t
		 where t.isin = ps_isin;
		vn_bilesikVerim   := (pn_ga_faizi / 36500 * vn_kupon_araligi + 1) **
												 (365 / vn_kupon_araligi) - 1;
		vn_kuponFaizi     := (1 + vn_bilesikVerim) ** (vn_kupon_araligi / 365) - 1;
		vn_anaparaBiriken := ((1 + vn_kuponFaizi) **
												 ((trunc(pd_ga_tarih) - trunc(pd_satis_tarih)) /
												 vn_kupon_araligi)) * pn_satis_fiyati;
		open c;
		loop
			fetch c
				into r_c;
			exit when c%notfound;
			vn_kuponBiriken := vn_kuponBiriken +
												 r_c.kupon_faizi *
												 (1 + vn_kuponFaizi) **
												 ((trunc(pd_ga_tarih) - trunc(r_c.vade)) /
												 vn_kupon_araligi);
		end loop;
		close c;
	
		return round(vn_anaparaBiriken - vn_kuponBiriken, 8);
	end;
	--------------------------
	procedure KuponluSatisHesapla(ps_isin         varchar2,
																pd_satis_tarih  date,
																pd_vade_tarihi  date,
																pn_satis_fiyati number,
																pn_faiz         number,
																pn_talep_tutar  number,
																--- out
																pn_toplam_tutar          out number,
																pn_birikmisKupon         out number,
																pn_kirliFiyat            out number,
																pn_temizFiyat            out number,
																pn_basitFaiz             out number,
																pn_bilesikFaiz           out number,
																pn_vadeyeKalanGun        out number,
																pn_vadesindeKirliFiyat   out number,
																pn_vadesindeTemizFiyat   out number,
																pn_nominal               out number,
																pn_VadesindeBrutGetiri   out number,
																pn_VadesindeburutTutar   out number,
																pn_vadeKadarToplamtTutar out number,
																pn_kupon_araligi         out number) is
		vn_kupon_araligi    number;
		vn_kupon_faizi      number;
		vn_toplam_faiz      number;
		vn_kupur            number;
		vc_sabit_degisken   char(1);
		vn_yilda_gun_sayisi number default 365;
		cursor c is
			select *
				from men_kupon k
			 where k.vade > pd_satis_tarih
				 and k.vade > trunc(pd_satis_tarih)
				 and k.isin = ps_isin;
		r_c c%rowtype;
	
		ld_yasayan_kupon_vadesi date;
	begin
		select t.kupon_gun_araligi,
					 c2.degisken_faizli,
					 trunc(t.vade) - trunc(pd_satis_tarih),
					 nvl(t.kupur, 100)
			into vn_kupon_araligi, vc_sabit_degisken, pn_vadeyeKalanGun, vn_kupur
			from men_tanim t, men_menkul_cinsleri c2
		 where t.isin = ps_isin
			 and t.cinsi = c2.cins_kodu;
		select sum(k.kupon_faizi)
			into vn_toplam_faiz
			from men_kupon k
		 where k.vade > pd_satis_tarih
			 and k.vade > trunc(pd_satis_tarih)
			 and k.isin = ps_isin;
		pn_basitFaiz := pn_faiz;
	
		--fiyattan faiz hesapla
		if nvl(pn_satis_fiyati, 0) > 0 then
			Kuponfiyattanfaizhesapla(ps_isin,
															 pd_satis_tarih,
															 pn_satis_fiyati,
															 (vn_toplam_faiz - pn_satis_fiyati) /
															 (pn_vadeyeKalanGun / 365),
															 pn_basitFaiz);
		end if;
	
		vn_kupon_faizi := pn_basitFaiz *
											(vn_kupon_araligi / vn_yilda_gun_sayisi);
		pn_bilesikFaiz := ((1 + vn_kupon_faizi / 100) **
											(365 / vn_kupon_araligi) - 1) * 100;
	
		pn_vadeyeKalanGun := trunc(pd_vade_tarihi) - trunc(pd_satis_tarih);
		kuponfaizindenfiyathesapla(ps_isin,
															 pd_satis_tarih,
															 pn_basitFaiz,
															 pn_kirlifiyat,
															 pn_temizFiyat);
	
		/*
        04.07.2016 Erkan Çalışkan
    
        hraç edilen Eurobond için;  
        işlem vadesi ilk kupon tarihinden önce ise; yani arada kupon ödenmeyecekse
        geri alış fiyatı iskontoluda olduğu gibi basit faiz formülü ile hesaplanacakmış.
        Vade tarihi kupon vadesini geçerse mevcut formülle hesaplamalar yapılmaya devam edecek.
        
        TYHAZ-1050
    */
	
		ld_yasayan_kupon_vadesi := YasayanKuponVadesi(pc_isin  => ps_isin,
																									pd_tarih => pd_satis_tarih);
		if ISINCinsKodu(ps_isin) = 'AKTEBOND' and
			 pd_vade_tarihi < ld_yasayan_kupon_vadesi then
			pn_vadesindeKirliFiyat := round(pn_kirlifiyat *
																			(1 + pn_basitFaiz * pn_vadeyeKalanGun /
																			36500.0),
																			8);
		else
			pn_vadesindeKirliFiyat := KuponluBonoGeriAlisFiyati(ps_isin,
																													pd_satis_tarih,
																													pd_vade_tarihi,
																													pn_kirlifiyat,
																													pn_basitFaiz);
		end if;
		pn_vadesindeTemizFiyat   := pn_vadesindeKirliFiyat -
																KuponluBirikmisKupon(ps_isin,
																										 pd_vade_tarihi);
		pn_nominal               := trunc((pn_talep_tutar /
																			(pn_kirliFiyat / 100)) / vn_kupur) *
																vn_kupur;
		pn_toplam_tutar          := round(pn_nominal * pn_kirliFiyat / 100, 2);
		pn_VadesindeburutTutar   := round(pn_nominal * pn_vadesindeKirliFiyat / 100,
																			2);
		pn_vadeKadarToplamtTutar := round(pn_nominal * vn_toplam_faiz / 100, 2);
		pn_VadesindeBrutGetiri   := pn_vadeKadarToplamtTutar - pn_toplam_tutar;
		pn_kupon_araligi         := vn_kupon_araligi;
	
	end;
	---------------------------------------------------
	procedure KuponFiyattanFaizHesapla(ps_isin          varchar2,
																		 pd_satis_tarih   date,
																		 pn_satis_fiyat   number,
																		 pn_referans_faiz number,
																		 pn_satis_oran    out number) is
	
		vn_count            number default 0;
		vn_acceptance       number default 0.000000001;
		vn_iteration_factor number default 5;
		vn_temp_faiz        number;
		vn_temp_fiyat       number;
		vn_temp_temiz_fiyat number;
		vn_fiyat_fark       number;
	
	begin
		vn_temp_faiz := pn_referans_faiz;
		loop
			exit when vn_count > 100;
		
			KuponFaizindenFiyatHesapla(ps_isin,
																 pd_satis_tarih,
																 vn_temp_faiz,
																 vn_temp_fiyat,
																 vn_temp_temiz_fiyat);
			vn_fiyat_fark := pn_satis_fiyat - vn_temp_fiyat;
			if vn_fiyat_fark <> 0 then
				vn_temp_faiz        := vn_temp_faiz +
															 vn_iteration_factor * vn_fiyat_fark /
															 abs(vn_fiyat_fark) * -1;
				vn_iteration_factor := vn_iteration_factor * 0.666;
			end if;
			vn_count := vn_count + 1;
		end loop;
		pn_satis_oran := vn_temp_faiz;
	end;

	-------------------------------------

	procedure KuponFaizindenFiyatHesapla(ps_isin        varchar2,
																			 pd_satis_tarih date,
																			 pn_faiz        number,
																			 pn_kirli_fiyat out number,
																			 pn_temiz_fiyat out number) is
	
		vn_kupon_araligi    number;
		vn_kupon_faizi      number;
		vn_son_kupon_faizi  number;
		vn_bilesik_faiz     number;
		vn_vadeye_kalan_gun number;
		vc_sabit_degisken   char(1);
		vd_itfa             date;
		vn_yilda_gun_sayisi number default 365;
		vn_birikmis         number default - 1;
		vd_baslangic        date;
	
		ln_gun_sayisi_yontemi number;
		ln_ggs                number; --geçen gün sayısı
	
		cursor c is
			select *
				from men_kupon k
			 where k.vade > pd_satis_tarih
				 and k.vade > trunc(pd_satis_tarih)
				 and k.isin = ps_isin;
		r_c c%rowtype;
	
	begin
		select t.kupon_gun_araligi, trunc(t.vade)
			into vn_kupon_araligi, vd_itfa
			from men_tanim t, men_menkul_cinsleri c2
		 where t.isin = ps_isin
			 and t.cinsi = c2.cins_kodu;
	
		ln_gun_sayisi_yontemi := pkg_menkul_finansal_hesaplama.Gun_Sayisi_Yontemi(ps_isin);
		vn_yilda_gun_sayisi   := pkg_menkul_finansal_hesaplama.Yil_Gun_Sayisi(ln_gun_sayisi_yontemi);
	
		vn_kupon_faizi := pn_faiz * (vn_kupon_araligi / vn_yilda_gun_sayisi);
		--vn_bilesik_faiz:= ((1 +vn_kupon_faizi/100) ** (365/vn_kupon_araligi) - 1 );
		vn_bilesik_faiz := ((1 + vn_kupon_faizi / 100) **
											 (vn_yilda_gun_sayisi / vn_kupon_araligi) - 1);
	
		pn_kirli_fiyat := 0;
		open c;
		loop
			fetch c
				into r_c;
			exit when c%notfound;
		
			-- 05.04.2016 Erkan Çalışkan 
			--pn_kirli_fiyat := pn_kirli_fiyat +    r_c.kupon_faizi / (1+  vn_kupon_faizi /100 )** ((trunc(r_c.vade) - trunc(pd_satis_tarih)) / vn_kupon_araligi)    ;
		
			ln_ggs         := pkg_menkul_finansal_hesaplama.Gun_Farki_Bul(pd_satis_tarih,
																																		r_c.vade,
																																		ln_gun_sayisi_yontemi);
			pn_kirli_fiyat := pn_kirli_fiyat +
												r_c.kupon_faizi / (1 + vn_kupon_faizi / 100) **
												(ln_ggs / vn_kupon_araligi);
		
			--     pn_kirli_fiyat := pn_kirli_fiyat +    r_c.kupon_faizi / (1+  vn_bilesikFaiz  )** ((trunc(r_c.vade) - trunc(pd_satis_tarih)) / 365)    ;
		end loop;
		close c;
		vn_birikmis    := KuponluBirikmisKupon(ps_isin, pd_satis_tarih);
		pn_temiz_fiyat := pn_kirli_fiyat - vn_birikmis;
		pn_kirli_fiyat := round(pn_kirli_fiyat, 8);
		pn_temiz_fiyat := round(pn_temiz_fiyat, 8);
	
	end;

	-------------------------------------------

	function KuponluBirikmisKupon(ps_isin varchar2, pd_tarih date)
		return number is
		vn_birikmis        number default - 1;
		vd_baslangic       date;
		vd_bitis           date;
		vn_son_kupon_faizi number;
	
		ln_gun_sayisi_yontemi number;
		ln_kgs                number; --kupon gün sayısı
		ln_ggs                number; --geçen gün sayısı
	begin
	
		if ISINKuponlumu(ps_isin) = 'H' then
			return 0;
		end if;
	
		select max(k.vade)
			into vd_baslangic
			from men_kupon k
		 where k.vade <= pd_tarih
			 and k.isin = ps_isin;
		if vd_baslangic is null then
			select t.ihrac_tarihi
				into vd_baslangic
				from men_tanim t
			 where t.isin = ps_isin;
		end if;
		select min(k.vade)
			into vd_bitis
			from men_kupon k
		 where k.vade > pd_tarih
			 and k.isin = ps_isin;
		if vd_bitis is null then
			select t.Vade into vd_bitis from men_tanim t where t.isin = ps_isin;
		end if;
		select k.kupon_faizi
			into vn_son_kupon_faizi
			from men_kupon k
		 where k.vade = vd_bitis
			 and k.isin = ps_isin;
	
		ln_gun_sayisi_yontemi := pkg_menkul_finansal_hesaplama.Gun_Sayisi_Yontemi(ps_isin);
		ln_kgs                := pkg_menkul_finansal_hesaplama.Gun_Farki_Bul(vd_baslangic,
																																				 vd_bitis,
																																				 ln_gun_sayisi_yontemi);
		ln_ggs                := pkg_menkul_finansal_hesaplama.Gun_Farki_Bul(vd_baslangic,
																																				 pd_tarih,
																																				 ln_gun_sayisi_yontemi);
	
		if trunc(pd_tarih) = trunc(vd_baslangic) then
			vn_birikmis := 0;
		else
			if vn_son_kupon_faizi > 100 then
				vn_son_kupon_faizi := vn_son_kupon_faizi - 100;
			end if;
			/*vn_birikmis := (trunc(pd_tarih) - trunc(vd_baslangic)) *
      vn_son_kupon_faizi / (vd_bitis - vd_baslangic);*/
		
			vn_birikmis := vn_son_kupon_faizi / ln_kgs * ln_ggs;
		end if;
	
		return round(vn_birikmis, 8);
	
	end;
	-----------------------------------

	function KuponGeliri(pc_isin         varchar2,
											 pd_kupon_vadesi date,
											 pn_kupon_orani  number,
											 pd_satis_tarihi date,
											 pn_nominal      number,
											 pn_satis_fiyati number) return number is
		vn_Birikmis_Faiz      number;
		vn_Kalan_Kupon_Sayisi number;
		vn_Temiz_Fiyat        number;
		vn_KBFO               number;
	
		vn_itfa_kupon_sayisi number;
		vn_Kupon_Gelir       number;
		vn_Islemis_Faiz      number;
		vn_Kupon_Fazla_Odeme number;
		vn_Kar_Zarar         number;
	
	begin
		/*
    30.01.2015 ERKAN ÇALIÞKAN
    
    Geçici 67 kanununa uygun oalrak brüt kupon gelirini hesaplar.
    */
	
		-- Temiz fiyat ve kupon başı fazla ödemesi hesaplanıyor
		vn_Birikmis_Faiz      := KuponluBirikmisKupon(pc_isin, pd_satis_tarihi);
		vn_Kalan_Kupon_Sayisi := KalanKuponSayisi(pc_isin, pd_satis_tarihi);
		vn_Temiz_Fiyat        := TemizFiyat(pn_satis_fiyati, vn_Birikmis_Faiz);
		vn_KBFO               := KuponBasiFazlaOdeme(pn_satis_fiyati,
																								 vn_Birikmis_Faiz,
																								 vn_Kalan_Kupon_Sayisi);
	
		vn_itfa_kupon_sayisi := ItfaKuponSayisi(pc_isin,
																						pd_kupon_vadesi,
																						pd_satis_tarihi);
	
		-- brüt ve net gelir hesaplanıyor
		IF vn_itfa_kupon_sayisi = 0 then
			-- ALIŞTAN SONRA HENÜZ KUPON İTFASI OLMAMIŞ
			vn_Kupon_Gelir       := round((pn_nominal * pn_kupon_orani) / 100, 2);
			vn_Islemis_Faiz      := round(pn_nominal *
																		(pn_satis_fiyati - vn_Temiz_Fiyat) / 100,
																		2);
			vn_Kupon_Fazla_Odeme := round(pn_nominal * vn_KBFO / 100, 2);
			vn_Kar_Zarar         := vn_Kupon_Gelir -
															(vn_Islemis_Faiz + vn_Kupon_Fazla_Odeme);
		ELSE
			-- ENAZ BİR TANE KUPON İTFASI OLMUŞ
			vn_Kupon_Gelir       := round((pn_nominal * pn_kupon_orani) / 100, 2);
			vn_Kupon_Fazla_Odeme := round(pn_nominal * vn_KBFO / 100, 2);
			vn_Kar_Zarar         := vn_Kupon_Gelir - vn_Kupon_Fazla_Odeme;
		end if;
	
		return vn_Kar_Zarar;
	
	end;

	-----------------------------------------------------------------------------------

	function KuponVergiTutariBB(pn_kupon_geliri number,
															pn_stopaj_orani number) return number is

		vn_vergi        number;
	begin
		/*
    30.01.2015 ERKAN ÇALIÞKAN
    
    Geçici 67 kanununa uygun oalrak kupon vergisini hesaplar.
    */
	
		vn_vergi        := ROUND(pn_kupon_geliri * pn_stopaj_orani / 100.0, 2);

		return vn_vergi;
	
	end;

	-----------------------------------------------------------------------------------

	function VergiHesaplaBB(pd_tarih          date,
													pn_satis_referans number,
													pn_musteri_no     number,
													pn_nominal        number,
													pn_fiyat          number) return number is
	
		vc_isin         varchar2(12);
		vd_satis_tarihi date;
		vn_satis_fiyati number;
		vn_Kar_Zarar    number;
		vn_vergi        number;
	
		vn_Birikmis_Faiz      number;
		vn_Kalan_Kupon_Sayisi number;
		vn_Temiz_Fiyat        number;
		vn_KBFO               number;
		vn_Stopaj_Orani       number;
		vn_donus_tutari       number;
		vn_itfa_kupon_sayisi  number;
	
		vc_emanetmi     char(1);
		vc_cins_kodu varchar2(25);
	
    ld_kademeli_stopaj_bas_tar date;
    ld_kademeli_stopaj_bit_tar date;
	begin
		/*
    03.02.2015 ERKAN ÇALIÞKAN
    
    Geçici 67 kanununa uygun olarak banka bonolarında alım satım vergisini hesaplar.
    */
	
		select s.isin, s.satis_tarihi, s.satis_birim_fiyat, s.emanet_eh, s.stopaj_oran
			into vc_isin, vd_satis_tarihi, vn_satis_fiyati, vc_emanetmi, vn_Stopaj_Orani
			from bb_satis s
		 where s.referans = pn_satis_referans;
	
   vc_cins_kodu := ISINCinsKodu(vc_isin);
    
    
    --23.12.2021 - 31.03.2021 tarihleir arası kademeli stopaj geçerli
    ld_kademeli_stopaj_bas_tar := pkg_parametre.Deger_Al_K_D('KADEMELI_STOPAJ_BAS_TARIH');
    ld_kademeli_stopaj_bit_tar := pkg_parametre.Deger_Al_K_D('KADEMELI_STOPAJ_BIT_TARIH');
          
    if (vd_satis_tarihi between ld_kademeli_stopaj_bas_tar and ld_kademeli_stopaj_bit_tar) 
         or vn_Stopaj_Orani is null then
       
       vn_Stopaj_Orani := pkg_menkul_hesapla.BBVergiOrani(pn_musteri_no,
                                                     vc_emanetmi,
                                                     vc_cins_kodu,
                                                     vc_isin,
                                                     vd_satis_tarihi,
                                                     pd_tarih
                                                     );
    end if;
    
      
		if ISINKuponlumu(vc_isin) = 'H' then
			--iskontolu
			vn_Kar_Zarar    := pkg_menkul_dibs_hesapla.TutarHesapla(vc_isin,
																															pn_nominal,
																															(pn_fiyat -
																															vn_satis_fiyati));
                                                    
			vn_Vergi        := ROUND(vn_Kar_Zarar * vn_Stopaj_Orani / 100.0, 2);
		else
			--kuponlu
			-- Temiz fiyat ve kupon başı fazla ödemesi hesaplanıyor
			vn_Birikmis_Faiz      := pkg_menkul_hesapla.KuponluBirikmisKupon(vc_isin,
																																			 vd_satis_tarihi);
			vn_Kalan_Kupon_Sayisi := pkg_menkul_hesapla.KalanKuponSayisi(vc_isin,
																																	 vd_satis_tarihi);
			vn_Temiz_Fiyat        := pkg_menkul_hesapla.TemizFiyat(vn_satis_fiyati,
																														 vn_Birikmis_Faiz);
			vn_KBFO               := pkg_menkul_hesapla.KuponBasiFazlaOdeme(vn_satis_fiyati,
																																			vn_Birikmis_Faiz,
																																			vn_Kalan_Kupon_Sayisi);
      
			--son kupon + ana para
			vn_itfa_kupon_sayisi := pkg_menkul_hesapla.ItfaKuponSayisi(vc_isin,
																																 pd_tarih,
																																 vd_satis_tarihi);
		
			if vn_itfa_kupon_sayisi = 0 then
				vn_Kar_Zarar := ROUND(pn_nominal * (pn_fiyat - vn_satis_fiyati) / 100,
															2);
			else
				vn_Kar_Zarar := ROUND(pn_nominal *
															(pn_fiyat - (vn_Temiz_Fiyat -
															vn_KBFO * vn_itfa_kupon_sayisi)) / 100,
															2);
			end if;
		
			vn_Vergi := ROUND(vn_Kar_Zarar * vn_Stopaj_Orani / 100.0, 2);
		end if;
	
		return vn_vergi;
	
	end;

	-----------------------------------------------------------------------------------

	function BBVergiOrani(pn_musteri_no   number,
												ps_emanetmi     varchar2,
												ps_menkul_cinsi varchar2,
												ps_isin         varchar2,
                        pd_alis_tarihi date,
                        pd_vade date) return number is
		vn_stopaj_orani number;
	
		vn_ihracci_kurum   number;
		vc_yurt_disi_ihrac varchar2(1);
		vn_ay_sayisi       number;
		vs_ulke_kodu       men_ihrac_kurum.ulke_kod%type;
		vn_kurum_tipi      number;
    
    vn_gun_sayisi     number;
    
    ld_kademeli_stopaj_bas_tar date;
    ld_kademeli_stopaj_bit_tar date;
	begin
	
		select mc.stopaj_oran
			into vn_stopaj_orani
			from men_menkul_cinsleri mc
		 where mc.cins_kodu = ps_menkul_cinsi;
	
		if pkg_musteri.tur(pn_musteri_no) in ('B', 'A') and
			 pkg_musteri.yurt_ici_disi(pn_musteri_no) = 'I' then
			return 0;
		end if;
		if ps_emanetmi <> 'E' then
			return 0;
		end if;
	
		--22.12.2016 Erkan Çalışkan
		--TY-7296 fonlarda vergi oranı 0
	
		if yatirim_fonu_mu(pn_musteri_no) = 'E' then
			return 0;
		end if;
	
		if ps_isin is null then
			return nvl(vn_stopaj_orani, 0);
		end if;
		
			/*
          01.06.2016 Erkan Çalışkan
          
          Kademeli Stopaj Oranı
          
          tam mükellef kurumlar tarafından yurt dışında ihraç edilen 
          tahvillerden yine aynı maddede sayılan kurumlar tarafından 
          aşağıdaki oranlar üzerinden tevkifat yapılacağı hüküm altına alınmıştır.
      
          i) Vadesi 1 yıla kadar olanlardan elde edilen faizlerinden % 10,
          ii) Vadesi 1 yıl ile 3 yıl arası olanlardan elde edilen faizlerinden % 7,
          iii) Vadesi 3 yıl ile 5 yıl arası olanlardan elde edilen faizlerinden % 3,
          iv) Vadesi 5 yıl ve daha uzun olanlardan elde edilen faizlerinden %0
      
      */
		
			select t.ihracci_kurum,
						 nvl(t.yurtdisi_ihracli, 'H'),
						 months_between(t.vade, t.ihrac_tarihi),
						 i.ulke_kod,
						 i.kurum_tipi
				into vn_ihracci_kurum,
						 vc_yurt_disi_ihrac,
						 vn_ay_sayisi,
						 vs_ulke_kodu,
						 vn_kurum_tipi
				from men_tanim t, men_ihrac_kurum i
			 where t.ihracci_kurum = i.id
				 and t.isin = ps_isin;
		
			--tam mükellef kurumlarca yurt dıdışında ihraç edilmiş kıymet
			if vs_ulke_kodu = 'TR' and vn_kurum_tipi <> 1 and
				 vc_yurt_disi_ihrac = 'E' then
				if vn_ay_sayisi >= 12 and vn_ay_sayisi < 36 then
					vn_stopaj_orani := 7;
				end if;
			
				if vn_ay_sayisi >= 36 and vn_ay_sayisi < 60 then
					vn_stopaj_orani := 3;
				end if;
			
				if vn_ay_sayisi >= 60 then
					vn_stopaj_orani := 0;
				end if;
			end if;
		
     
      
      /*
      
      
      Vergi ORanı Tarihçesi:
      
      1- 24.05.2020 öncesi bono, tahvil ve sukuklarda stopaj oranı %10 du
      
      2- 24.05.2020 tarihli genelge ile Finansman bonoların 
         ve bir yıldan kısa vadeli sukukların stopaj oranı %15 yapıldı.
      
      3- 23.12.2020 tarihli tebliğ ile 23.12.2020 - 31.03.2021 tarihleir arasında 
         geçerli olmak üzere Bankalrın ihraç ettikleri Bono ve tahviller ile 
         bankaların VKŞ leri tarafından ihraç edilmiş SUKUK larda
         kademeli veri oranına geçildi.
         
            --6 aydan kısa ise %5
            --1 yıldan kısa ise %3;
            --1 yıldan daha uzun ise %0;
        
       4 - 31.03.2021 üçüncü maddedeki kanunun süresi doldu artık ikinci maddedki
         kurallara geri dönüldü.
         
        Önemli Not: Her işlem kendi alış tarihindeki stopaj oranına tabidir. Sonradan çıkan
               kanunlar yeni yapılan işlemleri kapsıyor, eski alışları etkilemiyor.
      */
      
      
      
      if ps_menkul_cinsi in ('AFAB', 'BB','NKBONO','DKAKTTHV', 'AFAT',
                         'SKAKTTHV', 'NKTAHVIL','ISKAKTTHV') then

          
          ld_kademeli_stopaj_bas_tar := pkg_parametre.Deger_Al_K_D('KADEMELI_STOPAJ_BAS_TARIH');
          ld_kademeli_stopaj_bit_tar := pkg_parametre.Deger_Al_K_D('KADEMELI_STOPAJ_BIT_TARIH');
    
          --tebliğ öncesi yapılan alışlarda o tarihteki oranlar geçerli olacak.
          --geçmiş bonolar için iki farklı oran oldu
          if pd_alis_tarihi < TO_DATE('24.05.2020', 'DD.MM.YYYY') and ps_menkul_cinsi in ('AFAB', 'BB','NKBONO') 
                            and vn_Stopaj_Orani > 0  then
                            
            vn_Stopaj_Orani := 10.0;
            
            return vn_stopaj_orani;
            
          end if;
          
          if pd_alis_tarihi >= TO_DATE('24.05.2020', 'DD.MM.YYYY') and pd_alis_tarihi < ld_kademeli_stopaj_bas_tar
                            and ps_menkul_cinsi in ('AFAB', 'BB','NKBONO')
                            and vn_Stopaj_Orani > 0 then
                            
            vn_Stopaj_Orani := 15.0;
            
            return vn_stopaj_orani;
            
          end if;
          
          --taviller
          if pd_alis_tarihi < ld_kademeli_stopaj_bas_tar  and (ps_menkul_cinsi in ('DKAKTTHV', 'AFAT','SKAKTTHV', 'NKTAHVIL','ISKAKTTHV') 
             or substr(ps_isin, 1,3) = 'TRS') and vn_Stopaj_Orani > 0 then
                            
            vn_Stopaj_Orani := 10.0;
            
            return vn_stopaj_orani;
            
          end if;
      
        
          /*
          31.03.2021 tarihinde 23.12.2020 tarihinde çıkan vergi tebliği
          sona erdi, bir önceki haline geri döndü.
          */
          if pd_alis_tarihi >= ld_kademeli_stopaj_bas_tar and pd_alis_tarihi <= ld_kademeli_stopaj_bit_tar
                            and vn_Stopaj_Orani > 0 then
                --yeni tarihli satış ise
                vn_gun_sayisi := NVL(pd_vade - pd_alis_tarihi, 0);
                
                if vn_gun_sayisi <= 182 then                        
                  --6 aydan kısa ise
                  vn_Stopaj_Orani := 5;
                elsif vn_gun_sayisi <= 364 then 
                  --1 yıldan kısa ise
                  vn_Stopaj_Orani := 3;
                else
                  --1 yıldan daha uzun ise
                  vn_Stopaj_Orani := 0;
              end if;
           end if;
           
           
      end if;
      
      return nvl(vn_stopaj_orani, 0);
	
	end;

	-----------------------------------------------------------------------------------
	function YasayanKuponOrani(pc_isin varchar2, pd_tarih date) return number is
		vn_oran         number;
		vd_kupon_vadesi date;
	begin
		/*
    30.01.2015 ERKAN ÇALIÞKAN
    
    pd_tarih tarihnde yaþayan kuponun oranýný geri döner.
    */
	
		vd_kupon_vadesi := YasayanKuponVadesi(pc_isin, pd_tarih);
	
		SELECT k.kupon_faizi
			into vn_oran
			From men_kupon k
		 WHERE k.isin = pc_isin
			 and k.vade = vd_kupon_vadesi;
	
		return vn_oran;
	end;

	-----------------------------------------------------------------------------------

	function FiyatHesaplaIskontoluBB(pd_tarih         date,
																	 pn_iskonto_orani number,
																	 pd_isin_vadesi   date) return number is
		vn_vkg   number;
		vn_fiyat number;
	
	begin
		/*
                 06.10.2015 Erkan Çalışkan
                 
                 İskontolu banka bonolarında; iskonto oranından satış fiyatı hesaplar.
                 
                 Özellikle BİST (888 şubeden yapılan) alışlarında kullanılır.
                 
                 Not: fonksiyon dönüş değeri özellikle round yapılmadı! Fonksiyoun çağıran taraf
                 istediği dijite yuvarlayabilir.
                 
                 Not: İskontolu kıymetler fiyat 3 hane kullanılıyormuş. Ledia hanım istedi.
                 
    */
		vn_vkg   := pd_isin_vadesi - pd_tarih;
		vn_fiyat := round(100.0 / (1 + pn_iskonto_orani * vn_vkg / 36500), 8); --PBIYU-1192
	
		return vn_fiyat;
	end;
	----------------------------------------------------------------------

	function IskontoOraniHesaplaIskontoluBB(pd_tarih       date,
																					pn_fiyat       number,
																					pd_isin_vadesi date) return number is
		vn_vkg  number;
		vn_oran number;
	
	begin
		/*
                 06.10.2015 Erkan Çalışkan
                 
                 İskontolu banka bonolarında; satış fiyattan iskonto oranı hesaplar
                 
                 Özellikle BİST (888 şubeden) yapılan alışlarında kullanılır.
                 
                 Not: fonksiyon dönüş değeri özellikle round yapılmadı! Fonksiyoun çağıran taraf
                 istediği dijite yuvarlayabilir.
    */
		vn_vkg  := pd_isin_vadesi - pd_tarih;
		vn_oran := (100.0 / pn_fiyat - 1) * 36500.0 / vn_vkg;
	
		return vn_oran;
	end;
	----------------------------------------------------------------------
	function GAFiyatHesaplaIskontoluBB(pd_tarih        date,
																		 pn_ga_orani     number,
																		 pd_satis_tarihi date,
																		 pn_satis_fiyati number) return number is
		vn_vkg   number;
		vn_fiyat number;
	
	begin
		/*
                 07.10.2015 Erkan Çalışkan
                 
                 İskontolu banka bonolarında; geri alış fiyatından geri alış oranını hesaplar
                 
                 Özellikle şubeden yapılan alışlarında kullanılır.
                 
                 Not: fonksiyon dönüş değeri özellikle round yapılmadı! Fonksiyoun çağıran taraf
                 istediği dijite yuvarlayabilir.
                 
                 Not: İskontolu kıymetler fiyat 3 hane kullanılıyormuş. Ledia hanım istedi.
    */
	
		vn_vkg   := pd_tarih - pd_satis_tarihi;
		vn_fiyat := round(pn_satis_fiyati *
											(1 + pn_ga_orani * vn_vkg / 36500.0),
											8);
	
		return vn_fiyat;
	end;
	----------------------------------------------------------------------
	function GAOranHesaplaIskontoluBB(pd_tarih        date,
																		pn_ga_fiyati    number,
																		pd_satis_tarihi date,
																		pn_satis_fiyati number) return number is
		vn_vkg  number;
		vn_oran number;
	
	begin
		/*
                 07.10.2015 Erkan Çalışkan
                 
                 İskontolu banka bonolarında; geri alış fiyatından geri alış oranını hesaplar
                 
                 Özellikle şubeden yapılan alışlarında kullanılır.
                 
                 Not: fonksiyon dönüş değeri özellikle round yapılmadı! Fonksiyoun çağıran taraf
                 istediği dijite yuvarlayabilir.
                 
    */
	
		vn_vkg := pd_tarih - pd_satis_tarihi;
	
		--aynı gün geri alış yapılıyor
		if vn_vkg = 0 then
			return 0;
		end if;
	
		vn_oran := (pn_ga_fiyati / pn_satis_fiyati - 1) / vn_vkg * 36500.0;
	
		return vn_oran;
	end;
	----------------------------------------------------------------------

	Procedure BB_Geri_Alis_Hesapla_Fiyattan(pn_Talep_Nominal  in number,
																					pn_Talep_Tutar    in number,
																					pn_Faiz_Orani     in number,
																					pn_Iskonto_Orani  in number,
																					pn_Fiyat          in number,
																					pn_Satis_referans in number,
																					
																					p_Burut_Tutar        out number,
																					p_Net_Tutar          out number,
																					p_kalan_nominal      out number,
																					p_birim_fiyat        out number,
																					p_stopaj_kesintisi   out number,
																					p_stopaj_oran        out number,
																					p_bugunku_degeri     out number,
																					p_vadesindeki_degeri out number,
																					p_ga_nominal         out number,
																					p_isin               out varchar2,
																					pn_bugunku_fiyat     out number,
																					pn_faiz_oran         out number,
																					pn_odenen_net_tutar  out number,
																					pn_ihrac_farki       out number,
																					pn_taahhut           out number,
																					pn_brut_getiri       out number,
																					po_Iskonto_Orani     out number,
																					pd_islem_tarihi      date default trunc(pkg_muhasebe.Banka_Tarihi_Bul)
																					
																					) is
	
		vn_satis_fiyati  number;
		vn_kalan_nominal number;
		vn_gecen_gun     number;
		vn_ga_fiyat      number;
		vc_emanet        char(1);
		vn_satis_faiz    number;
		vn_musteri_no    number;
		vd_itfa          date;
		vd_satis_tarih   date;
		vc_cins_kodu     varchar2(10);
		vc_isin          varchar2(25);
		vn_bono_tipi     number;
		vn_taahhut       number;
		vd_ga_tarihi     date;
		vc_erken         varchar2(1) default 'H';
		vd_islem_tarihi  date;
	  
		vn_dummy number;
	
		ld_yasayan_kupon_vadesi date;
    
    ld_kademeli_stopaj_bas_tar date;
    ld_kademeli_stopaj_bit_tar date;
	begin
		/*
                     07.10.2015 Erkan Çalışkan
                     
                     TYHAZ-96
                     
                     BİST'ten yapılan geri alışların, fiyat veya iskonto oranından 
                     yapılabilmesi talep edildi.
                     
                     Öncelik Sıralaması:
                     
                             - Faiz (Geri Alış Faiz) Oranı
                             - İskonto Oranı
                             - Fiyat
    */
	
		--geri alış tarihi
		--vd_islem_tarihi := trunc(pkg_muhasebe.Banka_Tarihi_Bul);
	
		vd_islem_tarihi := pd_islem_tarihi;
	
		select s.satis_birim_fiyat,
					 s.kalan_nominal,
					 vd_islem_tarihi - trunc(s.satis_tarihi),
					 s.isin,
					 s.emanet_eh,
					 s.gerialis_birim_fiyat,
					 s.satis_faiz_oran,
					 s.musteri_no,
					 s.itfa_tarihi,
					 s.isin,
					 s.bono_tipi,
					 s.satis_tarihi,
					 s.kalan_taahhut,
					 s.vade_tarihi,
           s.stopaj_oran
			into vn_satis_fiyati,
					 vn_kalan_nominal,
					 vn_gecen_gun,
					 p_isin,
					 vc_emanet,
					 vn_ga_fiyat,
					 vn_satis_faiz,
					 vn_musteri_no,
					 vd_itfa,
					 vc_isin,
					 vn_bono_tipi,
					 vd_satis_tarih,
					 vn_taahhut,
					 vd_ga_tarihi,
           p_stopaj_oran
			from bb_satis s
		 where s.referans = pn_Satis_referans;
	
		if vn_bono_tipi < 3 then
			--iskontolu bono
			if pn_Faiz_Orani > 0 then
				pn_faiz_oran     := pn_Faiz_Orani;
				p_birim_fiyat    := GAFiyatHesaplaIskontoluBB(pd_tarih        => vd_islem_tarihi,
																											pn_ga_orani     => pn_faiz_oran,
																											pd_satis_tarihi => vd_satis_tarih,
																											pn_satis_fiyati => vn_satis_fiyati);
				po_Iskonto_Orani := IskontoOraniHesaplaIskontoluBB(pd_tarih       => vd_islem_tarihi,
																													 pn_fiyat       => p_birim_fiyat,
																													 pd_isin_vadesi => vd_itfa);
			elsif pn_Iskonto_Orani > 0 then
				po_Iskonto_Orani := pn_Iskonto_Orani;
				p_birim_fiyat    := FiyatHesaplaIskontoluBB(pd_tarih         => vd_islem_tarihi,
																										pn_iskonto_orani => po_Iskonto_Orani,
																										pd_isin_vadesi   => vd_itfa);
				pn_faiz_oran     := GAOranHesaplaIskontoluBB(pd_tarih        => vd_islem_tarihi,
																										 pn_ga_fiyati    => p_birim_fiyat,
																										 pd_satis_tarihi => vd_satis_tarih,
																										 pn_satis_fiyati => vn_satis_fiyati);
			
			else
				if nvl(pn_Fiyat, 0) > 0 then
					p_birim_fiyat := pn_Fiyat;
				else
					--21.10.2015 Erkan Çalışkan
					--girilen oran ve fiyat sıfır, yani satış fiyatından geri alınıyor.
					p_birim_fiyat := vn_satis_fiyati;
				end if;
			
				pn_faiz_oran := GAOranHesaplaIskontoluBB(pd_tarih        => vd_islem_tarihi,
																								 pn_ga_fiyati    => p_birim_fiyat,
																								 pd_satis_tarihi => vd_satis_tarih,
																								 pn_satis_fiyati => vn_satis_fiyati);
			
				po_Iskonto_Orani := IskontoOraniHesaplaIskontoluBB(pd_tarih       => vd_islem_tarihi,
																													 pn_fiyat       => p_birim_fiyat,
																													 pd_isin_vadesi => vd_itfa);
			end if;
		
			pn_bugunku_fiyat := round(vn_satis_fiyati *
																(1 + vn_satis_faiz * vn_gecen_gun / 36500.0),
																8);
			
		
    
      --18.04.2022 Erkan Çaliskan
      --PBIYU-1570
      --8 hane dijite geciste vade dönüs tutarinda kusurat farki olustugudan
      --05.02.2022 tarihinden once yapilan satislarin vade donusleri
      --3 hane olarak hesaplanýyor
      
      if trunc(vd_ga_tarihi) = trunc(pkg_muhasebe.banka_tarihi_bul) and trunc(vd_satis_tarih) < '05.02.2022' then
				p_birim_fiyat    := round(vn_satis_fiyati *
																(1 + pn_Faiz_Orani * vn_gecen_gun / 36500.0),
																3);
			  pn_bugunku_fiyat := round(vn_satis_fiyati *
																(1 + vn_satis_faiz * vn_gecen_gun / 36500.0),
																3);
			end if;
      
      --Itfa bugun ise fiyat 100 dur!!!
			if trunc(vd_itfa) = trunc(vd_islem_tarihi) then
				p_birim_fiyat    := 100;
				pn_bugunku_fiyat := 100;
			end if;
		
		else
			-- kuponlu demekki
		
			if trunc(vd_ga_tarihi) > trunc(vd_islem_tarihi) then
				vc_erken := 'E';
			end if;
		
			--kuponlu kıymetlerde; IRR yöntemle hesaplandığından
			--iskonto oranı ile alış oranı aynı.
			if pn_Faiz_Orani > 0 then
				pn_faiz_oran     := pn_Faiz_Orani;
				po_Iskonto_Orani := pn_Faiz_Orani;
			
				/*
          04.07.2016 Erkan Çalışkan
          
        işlem vadesi ilk kupon tarihinden önce ise; yani arada kupon ödenmeyecekse
        hespalamalar iskontolu gibi yapılacakmış.
        
        TYHAZ-1050
        */
				ld_yasayan_kupon_vadesi := YasayanKuponVadesi(pc_isin  => vc_isin,
																											pd_tarih => vd_satis_tarih);
				if ISINCinsKodu(vc_isin) = 'AKTEBOND' and
					 vd_islem_tarihi < ld_yasayan_kupon_vadesi then
					--henüz kupon itfası görmemiş, iskontolu gibi hesaplanıyor.
					p_birim_fiyat    := round(vn_satis_fiyati *
																		(1 +
																		pn_Faiz_Orani * vn_gecen_gun / 36500.0),
																		8);
					pn_bugunku_fiyat := round(vn_satis_fiyati *
																		(1 +
																		vn_satis_faiz * vn_gecen_gun / 36500.0),
																		8);
				else
					p_birim_fiyat := KuponluBonoGeriAlisFiyatiErken(ps_isin         => vc_isin,
																													pd_satis_tarih  => vd_satis_tarih,
																													pd_ga_tarih     => vd_islem_tarihi,
																													pn_satis_fiyati => vn_satis_fiyati,
																													pn_ga_faizi     => pn_Faiz_Orani,
																													ps_erkenmi      => vc_erken);
				
					pn_bugunku_fiyat := KuponluBonoGeriAlisFiyatiErken(vc_isin,
																														 vd_satis_tarih,
																														 pkg_muhasebe.Banka_Tarihi_Bul,
																														 vn_satis_fiyati,
																														 vn_satis_faiz,
																														 vc_erken);
				end if;
			
			elsif pn_Iskonto_Orani > 0 then
				pn_faiz_oran     := pn_Iskonto_Orani;
				po_Iskonto_Orani := pn_Iskonto_Orani;
			
				p_birim_fiyat := KuponluBonoGeriAlisFiyatiErken(ps_isin         => vc_isin,
																												pd_satis_tarih  => vd_satis_tarih,
																												pd_ga_tarih     => vd_islem_tarihi,
																												pn_satis_fiyati => vn_satis_fiyati,
																												pn_ga_faizi     => pn_Iskonto_Orani,
																												ps_erkenmi      => vc_erken);
			else
				if nvl(pn_Fiyat, 0) > 0 then
					p_birim_fiyat := pn_Fiyat;
					pn_faiz_oran  := round(KuponluBonoGeriAlisOraniErken(ps_isin         => vc_isin,
																															 pd_satis_tarih  => vd_satis_tarih,
																															 pd_ga_tarih     => vd_islem_tarihi,
																															 pn_satis_fiyati => vn_satis_fiyati,
																															 pn_ga_fiyati    => p_birim_fiyat,
																															 ps_erkenmi      => vc_erken),
																 4);
				else
					--21.10.2015 Erkan Çalışkan
					--girilen oran ve fiyat sıfır, yani sıfır orandan geri alınıyor.
					pn_faiz_oran  := 0;
					p_birim_fiyat := KuponluBonoGeriAlisFiyatiErken(ps_isin         => vc_isin,
																													pd_satis_tarih  => vd_satis_tarih,
																													pd_ga_tarih     => vd_islem_tarihi,
																													pn_satis_fiyati => vn_satis_fiyati,
																													pn_ga_faizi     => pn_faiz_oran,
																													ps_erkenmi      => vc_erken);
				end if;
			
				po_Iskonto_Orani := pn_faiz_oran;
			end if;
		
			pn_bugunku_fiyat := KuponluBonoGeriAlisFiyatiErken(vc_isin,
																												 vd_satis_tarih,
																												 pkg_muhasebe.Banka_Tarihi_Bul,
																												 vn_satis_fiyati,
																												 vn_satis_faiz,
																												 vc_erken);
		end if;
	
		p_ga_nominal := pn_Talep_Nominal;
		if nvl(pn_Talep_Nominal, 0) = 0 then
			p_ga_nominal := trunc(pn_Talep_Tutar / p_birim_fiyat) * 100;
		end if;
	
		select t.cinsi
			into vc_cins_kodu
			from men_tanim t
		 where t.isin = p_isin;
		
    --23.12.2021 - 31.03.2021 tarihleir arası kademeli stopaj geçerli
    ld_kademeli_stopaj_bas_tar := pkg_parametre.Deger_Al_K_D('KADEMELI_STOPAJ_BAS_TARIH');
    ld_kademeli_stopaj_bit_tar := pkg_parametre.Deger_Al_K_D('KADEMELI_STOPAJ_BIT_TARIH');
    
    if (vd_satis_tarih between ld_kademeli_stopaj_bas_tar and ld_kademeli_stopaj_bit_tar) 
         or p_stopaj_oran is null then
       
       p_stopaj_oran := bbvergiorani(vn_musteri_no,
																	vc_emanet,
																	vc_cins_kodu,
																	vc_isin,
                                  vd_satis_tarih,
                                  pkg_muhasebe.Banka_Tarihi_Bul
                                  );
    end if;
    
		pn_ihrac_farki := p_ga_nominal -
											round((p_ga_nominal * vn_satis_fiyati) / 100, 2);
		p_Burut_Tutar  := round((p_ga_nominal * p_birim_fiyat) / 100, 2);
		pn_brut_getiri := p_Burut_Tutar -
											round((p_ga_nominal * vn_satis_fiyati) / 100, 2);
	
		if p_stopaj_oran = 0 then
			p_stopaj_kesintisi := 0;
		else
			if vn_bono_tipi < 3 then
				p_stopaj_kesintisi := round(round(p_ga_nominal *
																					(p_birim_fiyat - vn_satis_fiyati) / 100,
																					2) * p_stopaj_oran / 100,
																		2);
			else
				p_stopaj_kesintisi := VergiHesaplaBB(vd_islem_tarihi,
																						 pn_satis_referans,
																						 vn_musteri_no,
																						 p_ga_nominal,
																						 p_birim_fiyat);
			end if;
		end if;
	
		p_Net_Tutar         := p_Burut_Tutar - p_stopaj_kesintisi;
		pn_odenen_net_tutar := p_Net_Tutar;
		p_kalan_nominal     := vn_kalan_nominal - p_ga_nominal;
	
		/*
    if p_kalan_nominal = 0 then
        pn_taahhut := vn_taahhut; -- hepsini bozmus
    else
        pn_taahhut := round(p_ga_nominal * vn_ga_fiyat / 100, 2);
    end if;
    */
	
		/**
    *
    *   07.06.2016 Erkan Çalışkan
    *
    *   bazı bb satış kayıtlarında TAAHHUT alanı null olduğundan
    *   hespalama yoluna gidildi. Tüm kaytlşarda taahhüt dolduğu emin
    *   olunduktan sonra yukarıdaki if buloğu açılabilr.
    *
    */
		--
		pn_taahhut := round(p_ga_nominal * vn_ga_fiyat / 100, 2);
		--
	
		p_bugunku_degeri     := round(p_kalan_nominal * pn_bugunku_fiyat / 100,
																	2);
		p_vadesindeki_degeri := round(p_kalan_nominal * vn_ga_fiyat / 100, 2);
	
	end;

	--------------------------
	function KuponluBonoGeriAlisOraniErken(ps_isin         varchar2,
																				 pd_satis_tarih  date,
																				 pd_ga_tarih     date,
																				 pn_satis_fiyati number,
																				 pn_ga_fiyati    number,
																				 ps_erkenmi      varchar2)
		return number is
	
		vn_dx        number;
		vn_fiyat     number; --þimdiki deðer
		vn_fark      number; --fark (nfiyat - nY)
		vn_oran      number;
		vn_alt_sinir number;
		vn_ust_sinir number;
		vn_result    number;
	
	begin
		/*
        08.10.2015 Erkan Çalışkan
        
        İterasyonala, kuponlu geri alış oranını hesaplar
        
        iterasyon sayısı 250.
        
    */
	
		vn_dx := 0.0000000001; --fark dx deðeriden küçükse olursa oran bulunmuþtur.
	
		vn_alt_sinir := 0;
		vn_ust_sinir := 1000;
		vn_oran      := vn_ust_sinir;
	
		vn_result := 0;
	
		For i in 1 .. 250 loop
			--fark, yeterince küçükse oran bulunmuþtur.
		
			vn_fiyat := KuponluBonoGeriAlisFiyatiErken(ps_isin,
																								 pd_satis_tarih,
																								 pd_ga_tarih,
																								 pn_satis_fiyati,
																								 vn_oran,
																								 ps_erkenmi);
		
			vn_fark   := vn_fiyat - pn_ga_fiyati;
			vn_result := vn_oran;
			exit when Abs(vn_fark) <= vn_dx;
		
			If vn_fark > 0 Then
				vn_ust_sinir := vn_oran;
			Else
				vn_alt_sinir := vn_oran;
			End If;
		
			vn_oran := (vn_ust_sinir + vn_alt_sinir) / 2.0;
		end loop;
	
		return vn_result;
	end;
	--------------------------

	--**************************************************************************************************************************

	Function Urun_Dokuman_Listesi(ps_URUN_KOD varchar2) return Rc_Menkul is
	
		rc_list RC_MENKUL;
	
	begin
	
		open rc_list for
			select pt.key2 kod, pt.text aciklama
				from gnl_param_text pt
			 where pt.kod = 'MEN_URUN_DOKUMAN_KODLARI'
				 and pt.key1 = ps_URUN_KOD;
	
		return rc_list;
	
	end;

	---***************************************************************----
	function TalimatNominal(pn_portfoy_id number) return number is
		vn_nom number;
	begin
		select nvl(sum(t.kalan_rezerv_nominal), 0)
			into vn_nom
			from men_talimat t
		 where t.talimat_tipi = 'A'
			 and t.durum = 'AKTIF'
			 and t.portfoyid = pn_portfoy_id;
	
		return nvl(vn_nom, 0);
	end;

	---***************************************************************----
	function TalimatNominalHist(pd_tarih date, pn_portfoy_id number)
		return number is
		vn_nom number;
	
	begin
	
		select nvl(sum(t.kalan_rezerv_nominal), 0)
			into vn_nom
			from men_talimat_hist t
		 where t.tarih = pd_tarih
			 and t.talimat_tipi = 'A'
			 and t.durum = 'AKTIF'
			 and t.portfoyid = pn_portfoy_id;
	
		return nvl(vn_nom, 0);
	end;

	---***************************************************************----
	function TalimatNominal(pn_musteri_no number, pn_portfoy_id number)
		return number is
		vn_nom number;
	begin
		/*
       11.05.2017 Erkan Çalışkan
       
       Müşterinin, portfoy id'ye ait bekleyen talimatını geri döner
    */
	
		select nvl(sum(t.kalan_rezerv_nominal), 0)
			into vn_nom
			from men_talimat t
		 where t.talimat_tipi = 'A'
			 and t.durum = 'AKTIF'
			 and t.musteri_no = pn_musteri_no
			 and t.portfoyid = pn_portfoy_id;
	
		return nvl(vn_nom, 0);
	end;

	---***************************************************************----
	function UygunIsinItfaTarihi(ps_menkul_cinsi varchar2,
															 pn_musteri_no   number,
															 pn_tutar        number,
															 pn_oran         number,
															 pn_komisyon     number default 0,
															 ps_ihrac_sekli  varchar2 default 'T',
															 ps_doviz        varchar2,
															 ps_emanetmi     varchar2,
															 pc_tuzel_bono   varchar2 default 'H')
		return date is
	
		ld_isin_vade date;
	
		ln_dummy number;
		ls_dummy varchar2(25);
	begin
	
		FiyatTutarIsinHesapla(ps_menkul_cinsi,
													pn_musteri_no,
													pn_tutar,
													pkg_muhasebe.Sonraki_Banka_Tarihi_Bul,
													pn_oran,
													pn_komisyon,
													ps_ihrac_sekli,
													ps_doviz,
													ps_emanetmi,
													pc_tuzel_bono,
													----  out lar
													ln_dummy,
													ls_dummy,
													ld_isin_vade,
													ln_dummy,
													ln_dummy,
													ln_dummy,
													ln_dummy,
													ln_dummy,
													ln_dummy,
													ln_dummy,
													ln_dummy,
													ln_dummy,
													ln_dummy,
													ln_dummy,
													ln_dummy,
													ls_dummy);
	
		return ld_isin_vade;
	
	end;

	---***************************************************************----
	Function yatirim_fonu_mu(pn_musteri_no number) return varchar2 is
	
		ls_musteri_tur gnl_musteri.musteri_tur_kod%type;
		ln_stat1       gnl_musteri.musteri_stat1%type;
		ln_stat2       gnl_musteri.musteri_stat2%type;
		ln_stat3       gnl_musteri.musteri_stat3%type;
	
		r_musteri gnl_musteri%ROWTYPE;
	
		lc_cevap varchar2(1);
	begin
	
		--22.12.2016 Erkan Çalışkan
	
		--yatırım fonu olup olmadığını geri döner
	
		r_musteri := pkg_tablo.musteri_kayit(pn_musteri_no);
	
		ls_musteri_tur := r_musteri.musteri_tur_kod;
		ln_stat1       := r_musteri.musteri_stat1;
		ln_stat2       := r_musteri.musteri_stat2;
		ln_stat3       := r_musteri.musteri_stat3;
	
		lc_cevap := 'H';
	
		if ls_musteri_tur = 'T' then
			/*
      1 3 1 Borsa Yatırım Fonları                                         Diğer Mali Kurum
      1 3 2 Borsa Yatırım Fonları (AB UCIT Direktiflerine Dahil Olmayan)  Diğer Mali Kurum
      1 3 3 Diğer Fonlar                                                  Diğer Mali Kurum
      1 3 4 Emeklilik Yatırım Fonları                                     Diğer Mali Kurum
      */
			if ln_stat1 = 1 and ln_stat2 = 3 then
				lc_cevap := 'E';
			end if;
		end if;
	
		return lc_cevap;
	end;

	---***************************************************************----
	Function BonoMusteriTuru(pn_musteri_no number, pn_referans number)
		return varchar2 is
		ln_gercek_musteri_no number;
	begin
	
		--04.04.2017 Erkan Çalışkan
	
		--AktifBank Dışarıdaki Müşteriler'e ait bir işlem ise
		--Gerçek müşterinin türünü geri döner.
	
		if pn_musteri_no =
			 pkg_parametre.ParamTextAl('MENKUL_KURUM_MUSTERI_NOLARI',
																 'BB_KONTAK_MUSTERI_NO') then
			--Kontak müştrden geri alış yapılmış, emanet çıkış kaydınan gerçek müşterisi bulunyor.
			select ec.musteri_no
				into ln_gercek_musteri_no
				from bnspr.bb_geri_alis_tx ga, bnspr.bb_emanet_cikis_tx ec
			 where ga.satis_referans = ec.referans
				 and ga.tx_no = pn_referans;
		
			return pkg_musteri.tur(ln_gercek_musteri_no);
		end if;
	
		return pkg_musteri.tur(pn_musteri_no);
	end;

	---***************************************************************----
	Function BonoMusteriHesapSube(pn_musteri_no number,
																pn_hesapno    number,
																pn_referans   number)
		return muh_hesap.sube_kodu%type is
		ln_gercek_hesap_no number;
		ln_doviz_kodu      bb_geri_alis.doviz_kod%type;
	begin
	
		--04.04.2017 Erkan Çalışkan
	
		--AktifBank Dışarıdaki Müşteriler'e ait bir işlem ise
		--Gerçek müşterinin hesap şube kodunu geri döner.
	
		if pn_musteri_no =
			 pkg_parametre.ParamTextAl('MENKUL_KURUM_MUSTERI_NOLARI',
																 'BB_KONTAK_MUSTERI_NO') then
			--Kontak müştrden geri alış yapılmış, emanet çıkış kaydınan gerçek müşterisi bulunyor.
			select ec.hesap_no
				into ln_gercek_hesap_no
				from bnspr.bb_geri_alis_tx ga, bnspr.bb_emanet_cikis_tx ec
			 where ga.satis_referans = ec.referans
				 and ga.tx_no = pn_referans;
		
			return pkg_hesap.sube_kodu(ln_gercek_hesap_no);
		end if;
	
		if pn_hesapno is null then
			--işlemin doviz kodu bulunuyor
			select ga.doviz_kod
				into ln_doviz_kodu
				from bnspr.bb_geri_alis_tx ga
			 where ga.tx_no = pn_referans;
		
			--muhabir hesap
			ln_gercek_hesap_no := pkg_parametre.ParamTextAl('MENKUL_MUHABIR_HESAP',
																											ln_doviz_kodu);
		
			return pkg_hesap.sube_kodu(ln_gercek_hesap_no);
		end if;
	
		return pkg_hesap.sube_kodu(pn_hesapno);
	end;
	---***************************************************************----
	Function BonoMusteriYurtIciDisi(pn_musteri_no number, pn_referans number)
		return varchar2 is
		ln_gercek_musteri_no number;
	begin
	
		--04.04.2017 Erkan Çalışkan
	
		--AktifBank Dışarıdaki Müşteriler'e ait bir işlem ise
		--Gerçek müşterinin yurt içi/dışı yerleşik olduğunu geri döner.
	
		if pn_musteri_no =
			 pkg_parametre.ParamTextAl('MENKUL_KURUM_MUSTERI_NOLARI',
																 'BB_KONTAK_MUSTERI_NO') then
			--Kontak müştrden geri alış yapılmış, emanet çıkış kaydınan gerçek müşterisi bulunyor.
			select t.musteri_no into ln_gercek_musteri_no
      from (
            select ec.musteri_no
              from bnspr.bb_geri_alis_tx ga, bnspr.bb_emanet_cikis_tx ec
             where ga.satis_referans = ec.referans
               and ga.tx_no = pn_referans
             union
            select ec.musteri_no
              from bnspr.bb_satis_kuponlar_tx sk, bnspr.bb_emanet_cikis_tx ec
             where sk.referans = ec.referans
               and sk.tx_no = pn_referans
         ) t;
         
 		
			return pkg_musteri.yurt_ici_disi(ln_gercek_musteri_no);
		end if;
	
		return pkg_musteri.yurt_ici_disi(pn_musteri_no);
	end;
	Function GetIstatistikKodu(ps_sahiplik   varchar2,
														 pn_musteri_no number,
														 ps_isin       varchar2,
														 ps_islem_turu varchar2,
														 ps_tutar_faiz varchar2) return varchar2 is
	
		istatistik_kodu varchar2(50);
	begin
	
		select t.istatistik_kod
			into istatistik_kodu
			from (select sta.istatistik_kod
							from bnspr.MEN_ISTATISTIK_KODU sta,
									 (select mt.bist_kote BORSAYA_KOTE_EH,
													 mt.yurtdisi_ihracli YURTDISI_IHRAC_EH,
													 decode(pn_musteri_no,
																	null,
																	'I',
																	bnspr.pkg_musteri.yurt_ici_disi(pn_musteri_no)) MUSTERI_YERLESIK,
													 case
														 when mn.cinsi in ('DTH', 'HZB') then
															'HZB/DTH'
														 else
															'DIGER'
													 end MENKUL_CINS,
													 case
														 when ik.ulke_kod = 'TR' THEN
															'I'
														 Else
															'D'
													 end IHRACCI_YERLESIK,
													 case
														 when ik.kurum_tipi in (1, 2, 3) THEN
															'HAZINE'
														 when ik.kurum_tipi in (7) THEN
															'BANKA'
														 Else
															'DIGER'
													 end IHRACCI_KURUM,
													 mt.doviz_kodu
											from bnspr.men_tanim       mt,
													 bnspr.men_tanim       mn,
													 bnspr.men_ihrac_kurum ik
										 where mt.ISIN = ps_isin
											 and ik.id = mn.ihracci_kurum
											 and mn.isin = mt.ISIN) a
						 where sta.sahiplik = nvl(ps_sahiplik, sta.sahiplik)
							 and sta.islem_turu = nvl(ps_islem_turu, sta.islem_turu)
							 and sta.tutar_faiz = nvl(ps_tutar_faiz, sta.tutar_faiz)
							 and nvl(sta.borsaya_kote_eh, a.borsaya_kote_eh) =
									 a.borsaya_kote_eh
							 and nvl(sta.yurtdisi_ihrac_eh, a.yurtdisi_ihrac_eh) =
									 a.yurtdisi_ihrac_eh
							 and nvl(sta.musteri_yerlesik, a.musteri_yerlesik) =
									 a.musteri_yerlesik
							 and nvl(sta.menkul_cins, a.menkul_cins) = a.menkul_cins
							 and nvl(sta.ihracci_yerlesik, a.ihracci_yerlesik) =
									 a.ihracci_yerlesik
							 and nvl(sta.ihracci_kurum, a.ihracci_kurum) = a.ihracci_kurum
							 and ps_islem_turu NOT IN
									 ('REPO', 'TERSREPO', 'REPODONUS', 'TERSREPODONUS')
						UNION ALL
						select sta.istatistik_kod
							from bnspr.MEN_ISTATISTIK_KODU sta,
									 (select mt.bist_kote BORSAYA_KOTE_EH,
													 mt.yurtdisi_ihracli YURTDISI_IHRAC_EH,
													 decode(pn_musteri_no,
																	null,
																	'I',
																	bnspr.pkg_musteri.yurt_ici_disi(pn_musteri_no)) MUSTERI_YERLESIK,
													 case
														 when mn.cinsi in ('DTH', 'HZB') then
															'HZB/DTH'
														 else
															'DIGER'
													 end MENKUL_CINS,
													 case
														 when ik.ulke_kod = 'TR' THEN
															'I'
														 Else
															'D'
													 end IHRACCI_YERLESIK,
													 case
														 when ik.kurum_tipi in (1) THEN
															'HAZINE'
														 Else
															'DIGER'
													 end IHRACCI_KURUM,
													 mt.doviz_kodu
											from bnspr.men_tanim       mt,
													 bnspr.men_tanim       mn,
													 bnspr.men_ihrac_kurum ik
										 where mt.ISIN = ps_isin
											 and ik.id = mn.ihracci_kurum
											 and mn.isin = mt.ISIN) a
						 where sta.sahiplik = nvl(ps_sahiplik, sta.sahiplik)
							 and sta.islem_turu = nvl(ps_islem_turu, sta.islem_turu)
							 and sta.tutar_faiz = nvl(ps_tutar_faiz, sta.tutar_faiz)
							 and nvl(sta.borsaya_kote_eh, a.borsaya_kote_eh) =
									 a.borsaya_kote_eh
							 and nvl(sta.yurtdisi_ihrac_eh, a.yurtdisi_ihrac_eh) =
									 a.yurtdisi_ihrac_eh
							 and nvl(sta.musteri_yerlesik, a.musteri_yerlesik) =
									 a.musteri_yerlesik
							 and nvl(sta.menkul_cins, a.menkul_cins) = a.menkul_cins
							 and nvl(sta.ihracci_yerlesik, a.ihracci_yerlesik) =
									 a.ihracci_yerlesik
							 and ((a.yurtdisi_ihrac_eh = 'E' and
									 nvl(sta.ihracci_kurum, a.ihracci_kurum) =
									 a.ihracci_kurum) or
									 (a.yurtdisi_ihrac_eh = 'H' and sta.ihracci_kurum is null))
							 and ps_islem_turu IN
									 ('REPO', 'REPODONUS', 'TERSREPO', 'TERSREPODONUS')
						
						) t;
	
		return istatistik_kodu;
	exception
		when others then
			return null;
	end;

	Function GetBonoTipi(ps_kupon_tipi varchar2) return varchar2 is
		v_bono_tipi varchar2(100);
	begin
		select bono_tipi
			into v_bono_tipi
			from KUPON_BONO_TIPI_ILISKI i
		 where i.kupon_tipi = ps_kupon_tipi;
	
		return v_bono_tipi;
	exception
		when others then
			pkg_hata.hata_yaz(5626, true, ps_kupon_tipi);
	end;

	Function GetKuponTipi(ps_bono_tipi varchar2) return varchar2 is
		v_kupon_tipi varchar2(100);
	begin
		select kupon_tipi
			into v_kupon_tipi
			from KUPON_BONO_TIPI_ILISKI i
		 where i.bono_tipi = ps_bono_tipi;
	
		return v_kupon_tipi;
	exception
		when others then
			pkg_hata.hata_yaz(5627, true, ps_bono_tipi);
	end;

	---***************************************************************----
	Function BonoMusteriTuruYeni(pn_musteri_no number, pn_referans number)
		return varchar2 is
		ln_gercek_musteri_no number;
	begin
	
		--04.04.2017 Erkan Çalışkan
	
		--AktifBank Dışarıdaki Müşteriler'e ait bir işlem ise
		--Gerçek müşterinin türünü geri döner.
	
		if pn_musteri_no =
			 pkg_parametre.ParamTextAl('MENKUL_KURUM_MUSTERI_NOLARI',
																 'BB_KONTAK_MUSTERI_NO') then
			--Kontak müştrden geri alış yapılmış, emanet çıkış kaydınan gerçek müşterisi bulunyor.
			select ec.musteri_no
				into ln_gercek_musteri_no
				from bnspr.bb_geri_alis_tx ga, bnspr.bb_emanet_cikis_tx ec
			 where ga.satis_referans = ec.referans
				 and ga.tx_no = pn_referans;
		
			return pkg_menkul_dibs_hesapla.Musteri_tur(ln_gercek_musteri_no, '');
		
		end if;
	
		return pkg_menkul_dibs_hesapla.Musteri_tur(pn_musteri_no, '');
	end;
	Function BugunkuDegerDibs(p_isin varchar2, p_nominal number, p_doviz_kodu varchar2, p_tarih date default pkg_muhasebe.Banka_Tarihi_Bul) return number is
		ln_bugunku_deger number;
		ln_fiyat         number;
		ln_nominal       number;
	begin
	
   if p_tarih >= pkg_muhasebe.Banka_Tarihi_Bul then
      SELECT f.fiyat
        INTO ln_fiyat
        FROM bnspr.men_vkn_gunluk_fiyat f
       WHERE f.ISIN = p_isin
       and f.doviz_kodu = p_doviz_kodu
       and f.tarih = (SELECT max(f.tarih)
                        FROM bnspr.men_vkn_gunluk_fiyat f
                       WHERE f.ISIN = p_isin
                       and f.doviz_kodu = p_doviz_kodu);
	
		else
      SELECT f.fiyat
        INTO ln_fiyat
        FROM bnspr.men_vkn_gunluk_fiyat f
       WHERE f.ISIN = p_isin
       and f.doviz_kodu = p_doviz_kodu
       and f.tarih = (SELECT max(f.tarih)
                        FROM bnspr.men_vkn_gunluk_fiyat f
                       WHERE f.ISIN = p_isin
                       and f.doviz_kodu = p_doviz_kodu
                       and f.tarih <= p_tarih);
	  end if;

    /*    
    04.01.2020 Erkan Çalışkan
    PBIYU-296
    
    vkn günlük fiyat tablosundaki fiyatlar 100'e bölünmüş tutulmaktadır
    o yüzden tekrar 100 e bölünmüyor.
    */
    
    ln_bugunku_deger := round(p_nominal * ln_fiyat, 2);
                                                             
		return ln_bugunku_deger;
	
	exception
		when no_data_found then
			return 0;
		
	end;
  
  Function BugunkuNetDegerBono(p_musteri_no number, p_isin varchar2, p_tarih date default pkg_muhasebe.Banka_Tarihi_Bul) return number is
    ln_sonuc number;
  begin
    /*
           25.12.2019 Erkan Çalışkan
           
           Müşterinin belli bir ISIN'a ait bonoların bugünkü değerlerin toplamını bulur.
    */
    
    if p_tarih >= pkg_muhasebe.Banka_Tarihi_Bul then
      select nvl(sum(BugunkuNetDegerBono(s.referans)), 0) into ln_sonuc
      from bb_satis s
      where s.musteri_no = p_musteri_no
      and s.isin = p_isin
      and s.durum = 'ONAY';
    else
       select sum(nvl(s.net_bugunku_deger, 0)) into ln_sonuc
      from bb_satis_hist s
      where s.tarih = p_tarih 
      and s.musteri_no = p_musteri_no
      and s.isin = p_isin
      and s.durum = 'ONAY';
    end if;
    
    return ln_sonuc;
  end;

  ---****************************************************************--
    /* Teminat Cıkısı*/
	function getTeminatNominal(pn_bono_hesap_no number) return number is
		vn_sum    number := 0;
	begin
    
      select sum(t.nominal_deger)
      into vn_sum
      from bnspr.tem_teminat_detail t
      where t.drm = 'A'
      and t.banka_bonosu_hesap_no = pn_bono_hesap_no;
   return nvl(vn_sum, 0);	
	end;
  
end PKG_MENKUL_HESAPLA;
/
