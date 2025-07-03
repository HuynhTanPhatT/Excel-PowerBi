


WITH project_status as (
SELECT	*,
		DATEDIFF(day,  [Thời hạn],[Hoàn thành]) as "Số Ngày Trễ Hạn"
FROM dbo.dataset1
),
data_anamoly as (
SELECT	*,
		(Case 
			WHEN [Số Ngày Trễ Hạn] < 0 Then 'Hoàn Thành Trước Hạn'
			WHEN [Số Ngày Trễ Hạn] = 0 Then 'Hoàn Thành Đúng Hạn'
			WHEN [Số Ngày Trễ Hạn] > 0 Then 'Hoàn Thành Trễ Hạn'
			Else 'Chưa Hoàn Thành' END) as project_status,
		(Case
			when [Bắt đầu] > [Thời hạn] Then  'Dữ Liệu Bất Thường' END) as Date_flag
from project_status
)
SELECT *
FROM data_anamoly
where Date_flag = 'Dữ Liệu Bất Thường'
ORDER BY [Khối] , [Số văn bản], [Bắt đầu],[Thời hạn], [Hoàn thành] ASC;