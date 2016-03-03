---
-- SCRIPT DE CREATION DU MODELE DVF+ 
-- ETAPE 1/2
-- 
-- Auteur: 
--    CEREMA "PCI Foncier et Stratégies Foncières"
--    Direction Territoriale Nord-Picardie
--    Antoine HERMAN
--    Jérôme DOUCHE
--
-- Ce script est fourni sous licence Creative Commons 3.0 CC-BY-SA
--
-- Début d'exécution le 03/03/2016 à 16:33:43
---

DROP SCHEMA IF EXISTS dvf_d59 CASCADE;

CREATE SCHEMA dvf_d59;

ALTER SEQUENCE dvf.mutation_plus_idmutation_seq RENAME TO mutation_idmutation_seq;

