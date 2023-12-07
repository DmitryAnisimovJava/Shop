import java.util.Arrays;

import dao.ItemsDao;
import entity.ItemsEntity;
import utlis.ConnectionPoolManager;

public class TestItemsDao {
	public static void main(String[] args) {
		try {
			ItemsDao.Insert(Arrays.asList(new ItemsEntity(null, "iphone 14", "Apple", "128gb Черный", 89990.00, 83),
										new ItemsEntity(null, "mi 11 lite", "Xiaomi", "256gb Белый", 16990.65, 114)));
		} finally {
			ConnectionPoolManager.closePool();
		}
	}
}