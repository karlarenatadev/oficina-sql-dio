USE oficina_dio;
GO

-- 1. Recuperações simples com SELECT e Filtros (WHERE)
-- Pergunta: Quais carros são do ano 2020 ou mais novos?
SELECT Model, Brand, Year, LicensePlate 
FROM Vehicles 
WHERE Year >= '2020'
ORDER BY Year DESC;

-- 2. Atributos Derivados e JOIN (A parte mais legal!)
-- Pergunta: Qual o custo TOTAL de peças para cada Ordem de Serviço?
-- (O SQL calcula: Quantidade * Valor da Peça)
SELECT 
    o.idOrder,
    v.Model,
    SUM(p.PartValue * op.Quantity) AS CustoTotalPecas
FROM Orders o
JOIN Vehicles v ON o.idVehicle = v.idVehicle
JOIN OrderParts op ON o.idOrder = op.idOrder
JOIN Parts p ON op.idPart = p.idPart
GROUP BY o.idOrder, v.Model;

-- 3. Filtros em Grupos (HAVING)
-- Pergunta: Quais mecânicos têm pelo menos 1 serviço atribuído?
SELECT 
    m.Name,
    COUNT(o.idOrder) AS Qtd_Servicos
FROM Mechanics m
JOIN Orders o ON m.idMechanic = o.idMechanic
GROUP BY m.Name
HAVING COUNT(o.idOrder) >= 1;

-- 4. Visão 360º (Múltiplos JOINs)
-- Relatório completo: Quem é o cliente, qual o carro, quem consertou e qual o status?
SELECT 
    c.Fname AS Cliente,
    v.Model AS Carro,
    m.Name AS Mecanico,
    o.OrderStatus AS Status,
    o.IssueDate AS Data_Entrada
FROM Orders o
INNER JOIN Vehicles v ON o.idVehicle = v.idVehicle
INNER JOIN Clients c ON v.idClient = c.idClient
INNER JOIN Mechanics m ON o.idMechanic = m.idMechanic;