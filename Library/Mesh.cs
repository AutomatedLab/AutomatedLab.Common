namespace Mesh
{
    public class Item<T> where T : class
    {
        private T source;
        private T destination;

        public T Source
        {
            get { return source; }
            set { source = value; }
        }

        public T Destination
        {
            get { return destination; }
            set { destination = value; }
        }

        public override string ToString()
        {
            return string.Format("{0} - {1}", source.ToString(), destination.ToString());
        }

        public override int GetHashCode()
        {
            return source.GetHashCode() ^ destination.GetHashCode();
        }

        public override bool Equals(object obj)
        {
            T otherSource = null;
            T otherDestination = null;

            if (obj == null)
                return false;

            if (obj.GetType().IsArray)
            {
                var array = (object[])obj;
                if (typeof(T) != array[0].GetType() || typeof(T) != array[1].GetType())
                    return false;
                else
                {
                    otherSource = (T)array[0];
                    otherDestination = (T)array[1];
                }

                if (!otherSource.Equals(this.source))
                    return false;

                return otherDestination.Equals(this.destination);
            }
            else
            {
                if (GetType() != obj.GetType())
                    return false;

                Item<T> otherObject = (Item<T>)obj;

                if (!this.destination.Equals(otherObject.destination))
                    return false;

                return this.source.Equals(otherObject.source);
            }
        }
    }
}
