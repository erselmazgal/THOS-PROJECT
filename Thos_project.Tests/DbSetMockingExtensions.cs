using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using Moq;

public static class DbSetMockingExtensions
{
    public static DbSet<T> GetQueryableMockDbSet<T>(params T[] entities) where T : class
    {
        var data = entities.AsQueryable();

        var mockSet = new Mock<DbSet<T>>();
        mockSet.As<IQueryable<T>>().Setup(m => m.Provider).Returns(data.Provider);
        mockSet.As<IQueryable<T>>().Setup(m => m.Expression).Returns(data.Expression);
        mockSet.As<IQueryable<T>>().Setup(m => m.ElementType).Returns(data.ElementType);
        mockSet.As<IQueryable<T>>().Setup(m => m.GetEnumerator()).Returns(data.GetEnumerator());

        return mockSet.Object;
    }
}
